//
//  NetworkLayer.swift
//  engenious-challenge
//
//  Created by Volodymyr Mykhailiuk on 10.02.2024.
//

import Foundation
import Combine

protocol NetworkLayerProtocol {
    /// Fetches data from the server using the provided request configuration and invokes the completion handler with the result.
    ///
    /// - Parameters:
    ///   - config: The request configuration specifying the base URL and endpoint.
    ///   - completion: The completion handler to be called when the request is completed, containing a result with either an array of decoded objects or an ApiError.
    func fetch<T: Codable>(
        config: RequestConfig,
        completion: @escaping (Result<[T], ApiError>) -> Void
    )
    /// Fetches data from the server using the provided request configuration and returns a publisher emitting the decoded objects or an error.
    ///
    /// - Parameter config: The request configuration specifying the base URL and endpoint.
    /// - Returns: A publisher emitting the decoded objects or an ApiError.
    func fetch<T: Decodable>(config: RequestConfig) -> AnyPublisher<[T], ApiError>
}

final class NetworkLayer: NetworkLayerProtocol {
    
    // MARK: - Properties
    private var urlSession: URLSession
    
    // MARK: - Init
    init(urlsession: URLSession) {
        self.urlSession = urlsession
    }
    
    // MARK: - Public Func
    func fetch<T: Codable>(
        config: RequestConfig,
        completion: @escaping (Result<[T], ApiError>) -> Void
    ) {
        guard let url = URL(string: config.baseURL + config.endpoint) else {
            return completion(.failure(.invalidURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = config.httpMethod.rawValue
        let task = urlSession.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if let error {
                completion(.failure(.networkError(error)))
                return
            }
            guard let data else {
                completion(.failure(.emptyResponse))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode([T].self, from: data)
                completion(.success(response))
            } catch let error {
                completion(.failure(.decodingError(error)))
            }
        })
        task.resume()
    }
    
    func fetch<T: Decodable>(config: RequestConfig) -> AnyPublisher<[T], ApiError> {
        guard let url = URL(string: config.urlString) else {
            return Fail(error: .invalidURL)
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = config.httpMethod.rawValue
        return urlSession.dataTaskPublisher(for: request)
            .mapError { error in
                ApiError.networkError(error)
            }
            .flatMap { data, response -> AnyPublisher<[T], ApiError> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(error: .invalidResponse)
                        .eraseToAnyPublisher()
                }
                guard 200 ..< 300 ~= httpResponse.statusCode else {
                    return Fail(error: .httpError(httpResponse.statusCode))
                        .eraseToAnyPublisher()
                }
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                return Just(data)
                    .decode(type: [T].self, decoder: decoder)
                    .mapError { error in
                        ApiError.decodingError(error)
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}


struct RequestConfig {
    enum HTTPMethod: String {
        case get = "GET"
    }
    
    let baseURL: String
    let endpoint: String
    let httpMethod: HTTPMethod
    
    init(
        baseURL: String = AppConstants.baseURL,
        endpoint: String,
        httpMethod: HTTPMethod
    ) {
        self.baseURL = baseURL
        self.endpoint = endpoint
        self.httpMethod = httpMethod
    }
    
    var urlString: String {
        "\(baseURL)/\(endpoint)"
    }
}

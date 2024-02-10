//
//  NetworkLayer.swift
//  engenious-challenge
//
//  Created by Volodymyr Mykhailiuk on 10.02.2024.
//

import Foundation
import Combine

protocol NetworkLayerProtocol {
    func fetch<T: Codable>(
        config: RequestConfig,
        completion: @escaping (Result<[T], ApiError>) -> Void
    )
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
        
        let request = URLRequest(url: url)
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
        
        let request = URLRequest(url: url)
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
    let baseURL: String
    let endpoint: String
    
    init(
        baseURL: String = "https://api.github.com",
        endpoint: String
    ) {
        self.baseURL = baseURL
        self.endpoint = endpoint
    }
    
    var urlString: String {
        "\(baseURL)/\(endpoint)"
    }
}

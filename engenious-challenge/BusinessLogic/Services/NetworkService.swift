//
//  NetworkService.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import Foundation
import Combine

protocol ResponseValidator {
    func validate(_ response: HTTPURLResponse) throws
}

enum ResponseValidationError: Error, Equatable {
    case unacceptableCode(Int)
}

struct StatusCodeValidator: ResponseValidator {
    func validate(_ response: HTTPURLResponse) throws {
        guard (200...299).contains(response.statusCode) else {
            throw ResponseValidationError.unacceptableCode(response.statusCode)
        }
    }
}

typealias DataLoaderHandler = (Swift.Result<Data, EndpointError>) -> Void
typealias RepositoryFetchHandler = (Result<[Repo], EndpointError>) -> ()
typealias RepositoryPublisher = AnyPublisher<[Repo], EndpointError>

protocol RepositoryService {
    func getUserRepos(endpoint: Endpoint, completion: @escaping RepositoryFetchHandler)
    func getUserReposPublisher(endpoint: Endpoint) -> RepositoryPublisher
}

final class RepositoryServiceImpl: RepositoryService {
    private let session: URLSession
    private let decoder: JSONDecoder
    private let responseValidator: ResponseValidator
    
    init(session: URLSession,
         decoder: JSONDecoder,
         responseValidator: ResponseValidator) {
        self.session = session
        self.decoder = decoder
        self.responseValidator = responseValidator
    }
    
    private func request(_ endpoint: Endpoint, then handler: @escaping DataLoaderHandler) {
        guard let url = endpoint.url else {
            return handler(.failure(EndpointError.invalidURL))
        }
        
        let task = session.dataTask(with: url) { [responseValidator] data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                handler(.failure(.invalidResponse(response)))
                return
            }
            
            do {
                try responseValidator.validate(httpResponse)
            } catch {
                handler(.failure(.validation(error)))
            }
            
            let result = data.map(Result.success) ?? .failure(EndpointError.network(error))
            handler(result)
        }
        
        task.resume()
    }
    
    func getUserRepos(endpoint: Endpoint, completion: @escaping RepositoryFetchHandler) {
        request(endpoint) { [decoder] result in
            switch result {
            case .success(let data):
                do {
                    let response = try decoder.decode([Repo].self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.invalidData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getUserReposPublisher(endpoint: Endpoint) -> RepositoryPublisher {
        guard let url = endpoint.url else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .tryMap { [responseValidator] data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw EndpointError.invalidResponse(response)
                }
                try responseValidator.validate(httpResponse)
                return data
            }
            .decode(type: [Repo].self, decoder: decoder)
            .mapError { error -> EndpointError in
                return error as? EndpointError ?? .network(error)
            }
            .eraseToAnyPublisher()
    }
}

extension RepositoryServiceImpl {
    static func makeDefault() -> RepositoryServiceImpl {
        let session = URLSession.shared
        let decoder = JSONDecoder()
        let responseValidator = StatusCodeValidator()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return RepositoryServiceImpl(session: session,
                                     decoder: decoder,
                                     responseValidator: responseValidator)
    }
}

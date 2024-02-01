//
//  RepositoryService.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import Foundation
import Combine

protocol RepositoryServiceProtocol {
    func getUserRepos(username: String, completion: @escaping (Result<[Repo], RepositoryService.ServiceError>) -> Void)
    func getUserReposCombine(username: String) -> AnyPublisher<[Repo], RepositoryService.ServiceError>
}

class RepositoryService: RepositoryServiceProtocol {

    enum ServiceError: Error {
        case invalidURL
        case networkError
        case decodingError
    }

    func getUserRepos(username: String, completion: @escaping (Result<[Repo], ServiceError>) -> Void) {
        guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else {
            completion(.failure(.invalidURL))
            return
        }

        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.networkError))
                return
            }
            guard let data = data else {
                completion(.failure(.networkError))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode([Repo].self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }

    func getUserReposCombine(username: String) -> AnyPublisher<[Repo], ServiceError> {
        guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Repo].self, decoder: JSONDecoder())
            .mapError { error in
                if error is DecodingError {
                    return .decodingError
                } else {
                    return .networkError
                }
            }
            .eraseToAnyPublisher()
    }
}

//
//  RepositoryService.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import Foundation
import Combine

protocol RepositoryServiceProtocol {
    func getUserRepos(username: String) -> AnyPublisher<[RepoDataModel], ApiError>
    func getUserRepos(
        username: String,
        completion: @escaping (Result<[RepoDataModel], ApiError>) -> Void
    )
}

final class RepositoryService: RepositoryServiceProtocol {
    func getUserRepos(username: String) -> AnyPublisher<[RepoDataModel], ApiError> {
        Future { promise in
            self.getUserRepos(username: username) { result in
                switch result {
                case .success(let response):
                    promise(.success(response))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getUserRepos(
        username: String,
        completion: @escaping (Result<[RepoDataModel], ApiError>) -> Void
    ) {
        guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else {
            return completion(.failure(.invalidURL))
        }
        
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if let error {
                return completion(.failure(.networkError(error)))
            }
            guard let data else {
                return completion(.failure(.emptyResponse))
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode([RepoDataModel].self, from: data)
                completion(.success(response))
            } catch let error {
                return completion(.failure(.decodingError(error)))
            }
        })
        task.resume()
    }
}

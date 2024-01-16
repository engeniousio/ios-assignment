//
//  NetworkService.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import Foundation
import Combine

protocol RepositoryServiceProtocol {
    func getUserRepos(username: String, completion: @escaping (Result<[RepositoryModel], ErrorTypes>) -> Void)
}

final class CombineRepositoryService: RepositoryServiceProtocol {
    var cancellables = Set<AnyCancellable>()
    
    func getUserRepos(username: String, completion: @escaping (Result<[RepositoryModel], ErrorTypes>) -> Void) {
        guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else {
            completion(.failure(.invalidURL("Error forming URL")))
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [RepositoryModel].self, decoder: JSONDecoder())
            .mapError { error -> ErrorTypes in
                return .invalidURL(error.localizedDescription)
            }
            .sink { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    completion(.failure(.failureResponse(error.localizedDescription)))
                }
            } receiveValue: { repos in
                completion(.success(repos))
            }
            .store(in: &cancellables)
    }
}

final class AsyncRepositoryService: RepositoryServiceProtocol {
    func getUserRepos(username: String, completion: @escaping (Result<[RepositoryModel], ErrorTypes>) -> Void) {
        Task {
            do {
                let repos = try await self.fetchUserRepos(username: username)
                completion(.success(repos))
            } catch {
                completion(.failure(.invalidURL(error.localizedDescription)))
            }
        }
    }
    
    private func fetchUserRepos(username: String) async throws -> [RepositoryModel] {
            guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else {
                throw ErrorTypes.invalidURL("Error")
            }

            let (data, _) = try await URLSession.shared.data(from: url)
            let repos = try JSONDecoder().decode([RepositoryModel].self, from: data)
            return repos
        }
}

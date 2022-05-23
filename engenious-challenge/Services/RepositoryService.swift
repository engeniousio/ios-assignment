//
//  NetworkService.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import Foundation
import Combine

protocol RepositoryServiceProtocol {
    func getUserRepoCombine(username: String) -> AnyPublisher<[Repo], Error>
    func getUserRepos(username: String, completion: @escaping ([Repo]) -> Void)
}

struct RepositoryService {

    let networkService: NetworkServiceProtocol

    init(_ networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

extension RepositoryService: RepositoryServiceProtocol {
    func getUserRepoCombine(username: String) -> AnyPublisher<[Repo], Error> {
        networkService.send(GetReposRequest(username: username)).eraseToAnyPublisher()
    }

    func getUserRepos(username: String, completion: @escaping ([Repo]) -> Void) {
        networkService.send(GetReposRequest(username: username)) { repos, error in
            guard let repos = repos else {
                return
            }
            completion(repos)

        }
    }
}

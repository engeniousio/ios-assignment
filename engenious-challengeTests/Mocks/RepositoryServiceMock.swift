//
//  RepositoryServiceMock.swift
//  engenious-challengeTests
//
//  Created by Oleg Granchenko on 31.01.2024.
//

import Foundation
import Combine

class RepositoryServiceMock: RepositoryServiceProtocol {

    var shouldSucceed: Bool = true
    var combinePublisher: AnyPublisher<[Repo], RepositoryService.ServiceError>!


    func getUserRepos(username: String, completion: @escaping (Result<[Repo], RepositoryService.ServiceError>) -> Void) {
        if shouldSucceed {
            let sampleRepos = [
                Repo(name: "Repo1", description: "Description1", url: "URL1"),
                Repo(name: "Repo2", description: "Description2", url: "URL2")
            ]
            completion(.success(sampleRepos))
        } else {
            completion(.failure(.networkError))
        }
    }

    func getUserReposCombine(username: String) -> AnyPublisher<[Repo], RepositoryService.ServiceError> {
        return combinePublisher
    }
}

//
//  MockRepositoryService.swift
//  engenious-challengeTests
//
//  Created by Volodymyr Mykhailiuk on 11.02.2024.
//

import Foundation
import XCTest
import Combine
@testable import engenious_challenge

final class MockRepositoryService: RepositoryServiceProtocol {
    var repositories: [RepoDataModel] = []
    var error: ApiError?
    
    func getUserRepos(username: String) -> AnyPublisher<[RepoDataModel], ApiError> {
        if let error {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        return Just(repositories)
            .setFailureType(to: ApiError.self)
            .eraseToAnyPublisher()
    }
    
    func getUserRepos(
        username: String,
        completion: @escaping (Result<[RepoDataModel], ApiError>) -> Void
    ) {
        if let error {
            completion(.failure(error))
            return
        }
        completion(.success(repositories))
    }
}

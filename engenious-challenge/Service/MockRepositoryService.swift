//
//  MockRepoService.swift
//  engenious-challenge
//
//  Created by Eugene Fozekosh on 14.02.2024.
//

import Foundation
import Combine

struct MockRepositoryService: RepositoryServiceProtocol {
    var result: Result<[Repo], Error>

    func getUserRepos(username: String) -> AnyPublisher<[Repo], Error> {
        return result.publisher
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func getUserRepos(username: String, completion: @escaping ([Repo]) -> Void) {
        switch result {
        case .success(let repos):
            completion(repos)
        case .failure:
            completion([])
        }
    }
}

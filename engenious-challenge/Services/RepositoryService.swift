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
    let networkLayer: NetworkLayerProtocol
    
    init(networkLayer: NetworkLayerProtocol) {
        self.networkLayer = networkLayer
    }
    
    func getUserRepos(username: String) -> AnyPublisher<[RepoDataModel], ApiError> {
        let config = RequestConfig(
            endpoint: "users/\(username)/repos",
            httpMethod: .get
        )
        return networkLayer.fetch(config: config)
    }
    
    func getUserRepos(
        username: String,
        completion: @escaping (Result<[RepoDataModel], ApiError>) -> Void
    ) {
        let config = RequestConfig(
            endpoint: "users/\(username)/repos",
            httpMethod: .get
        )
        
        networkLayer.fetch(config: config) { (result: Result<[RepoDataModel], ApiError>) in
            switch result {
            case .success(let repos):
                completion(.success(repos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

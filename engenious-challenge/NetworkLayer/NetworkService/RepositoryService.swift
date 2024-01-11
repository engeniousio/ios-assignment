//
//  RepositoryService.swift
//  engenious-challenge
//
//  Created by Юлія Воротченко on 11.01.2024.
//

import Foundation
import Combine

class RepositoryService: RepositoryServiceProtocol {
    private var networkRequest: Requestable
    
    func repositories(request: RepositoryDTO) -> AnyPublisher<RepositoryResponse, NetworkError> {
        let endpoint = Endpoints.getUserRepos(request: request)
        let request = endpoint.createRequest()
        return self.networkRequest.request(request)
    }
   
    // inject this for testability
    init(networkRequest: Requestable = NativeRequestable()) {
        self.networkRequest = networkRequest
    }
}

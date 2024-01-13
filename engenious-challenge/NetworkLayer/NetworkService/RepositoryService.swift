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
    
    func repositories(request: RepositoryDTO) -> AnyPublisher<[Repository], NetworkError> {
        let endpoint = Endpoints.getUsersRepos(request: request)
        let request = endpoint.createRequest()
        return self.networkRequest.request(request)
    }
   
    init(networkRequest: Requestable = Request()) {
        self.networkRequest = networkRequest
    }
}

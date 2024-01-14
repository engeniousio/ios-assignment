//
//  RepositoryService.swift
//  engenious-challenge
//
//  Created by Юлія Воротченко on 11.01.2024.
//

import Foundation
import Combine

protocol CombinedRepositoryServiceProtocol:  RepositoryServiceProtocol, 
                                            OldRepositoryServiceProtocol {

}

class RepositoryService: CombinedRepositoryServiceProtocol {
    private var networkRequest: Requestable
    
    init(networkRequest: Requestable = Request()) {
        self.networkRequest = networkRequest
    }
    
    
    func repositories(request: RepositoryDTO) -> AnyPublisher<[Repository], NetworkError> {
        let endpoint = Endpoints.getUsersRepos(request: request)
        let request = endpoint.createRequest()
        return self.networkRequest.request(request)
    }
   
   
    func repositories(repositoryDTO: RepositoryDTO,
                      completion: @escaping (Result<[Repository], NetworkError>) -> Void) {
        let endpoint = Endpoints.getUsersRepos(request: repositoryDTO)
        let request = endpoint.createRequest()
        let oldService = OldRepositoryService()
        oldService.getUsersRepositories(reporitoryDTO: repositoryDTO,
                                request: request,
                                completion: completion)
    }
}

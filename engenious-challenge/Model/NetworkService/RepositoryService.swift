//
//  RepositoryService.swift
//  engenious-challenge
//
//  Created by Misha Dovhiy on 09.01.2024.
//

import Foundation

struct RepositoryService {
    
    private let networkService:NetworkService = .init()
    
    func getRepositories(username: String) async -> ServerResponse {
        
        let response = await networkService.request(endpoint:.repositories, parameters:username)
        guard let result = response.data as? [Repository] else {
            return .error(.emptyResponse)
        }
        return response
    }
    
    func fetchRepositories(username: String) {
        Task {
            let response = await getRepositories(username: username)
            guard let result = response.data as? [Repository] else {
                await updateObtherver(.error(.emptyResponse))
                return
            }
            if let error = response.error {
                await updateObtherver(.error(error))
            }
            await updateObtherver(.success(result))
        }
    }
    
    @MainActor private func updateObtherver(_ response:ServerResponse) {
        NetworkPublisher.response.send(response)
    }
}


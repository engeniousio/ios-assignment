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
        guard let _ = response.data as? [Repository] else {
            if let error = response.error {
                return .error(error)
            }
            return .error(.emptyResponse)
        }
        return response
    }
    
    /**
     - updates results in NetworkPublisher.response
     */
    func fetchRepositories(username: String) {
        Task {
            let response = await getRepositories(username: username)
            guard let result = response.data as? [Repository] else {
                if let error = response.error {
                    await updateObzerver(.error(error))
                } else {
                    await updateObzerver(.error(.emptyResponse))
                }
                return
            }
            if let error = response.error {
                await updateObzerver(.error(error))
            }
            await updateObzerver(.success(result))
        }
    }
    
    @MainActor private func updateObzerver(_ response:ServerResponse) {
        NetworkPublisher.response.send(response)
    }
}


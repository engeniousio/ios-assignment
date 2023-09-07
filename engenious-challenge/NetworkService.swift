//
//  NetworkService.swift
//  engenious-challenge
//
//  Created by Mikita Dzmitrievich on 7.09.23.
//

import Foundation

protocol NetworkService {
    init(apiClient: APIClient)
    func userRepos(with username: String) async throws -> [RepoModel]
}

final class NetworkServiceImplementation: NetworkService {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient = APIClient.shared) {
        self.apiClient = apiClient
    }

    func userRepos(with username: String) async throws -> [RepoModel] {
        guard !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw APIClient.CustomError.incorrectUrl
        }
        let path = "/users/\(username)/repos"
        return try await apiClient.performRequest(path: path)
    }
}

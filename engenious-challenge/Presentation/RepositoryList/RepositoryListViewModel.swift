//
//  RepositoryListViewModel.swift
//  engenious-challenge
//
//  Created by Volodymyr Mykhailiuk on 09.02.2024.
//

import Foundation
import Combine

final class RepositoryListViewModel {
    enum State {
        case loading
        case loaded([RepoDataModel])
        case failed(ApiError)
    }
    
    private let username: String = "Apple"
    private let repositoryService: RepositoryServiceProtocol
    
    @Published private(set) var navigationTitle = ""
    @Published private(set) var repoList: [RepoDataModel] = []
    
    init(repositoryService: RepositoryServiceProtocol = RepositoryService()) {
        self.repositoryService = repositoryService
    }
    
    func setup() {
        navigationTitle = "\(username)'s repos"
        repositoryService.getUserRepos(username: username) { [weak self] in
            self?.repoList = $0
        }
    }
}

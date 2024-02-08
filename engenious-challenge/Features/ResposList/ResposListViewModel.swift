//
//  ResposListViewModel.swift
//  engenious-challenge
//
//  Created by Yulian on 08.02.2024.
//

import Combine
import Foundation

class ResposListViewModel: ObservableObject {
    var cancellables: Set<AnyCancellable> = []
    
    private let repositoryService: RepositoryServiceProtocol
    
    private var username: String = "Apple"
    
    var reposCount: Int {
        repoList.count
    }
    
    @Published private(set) var repoList: [Repo] = []
    
    @Published private(set) var viewControllerTitle: String

    
    init(repositoryService: RepositoryService) {
        self.repositoryService = repositoryService
        
        viewControllerTitle = "\(username)'s repos"
        
        getRepos()
    }
    
    func getRepos() {
        repositoryService.getUserRepos(username: username) { value in
            DispatchQueue.main.async {
                self.repoList = value
            }
        }
    }
}

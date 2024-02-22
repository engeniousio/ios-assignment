//
//  RepoViewModel.swift
//  engenious-challenge
//
//  Created by Pavlo on 22.02.2024.
//

import Foundation
import Combine

final class RepoViewModel: ViewModelProtocol {
    private let repositoryService: RepositoryService
    private let username: String = "Apple"

    @Published var repoList: [Repo] = []
    
    var cancellables: Set<AnyCancellable> = []
    
    var title: String {
        return "\(username)'s repos"
    }
    
    init(repositoryService: RepositoryService = RepositoryServiceImpl.makeDefault()) {
        self.repositoryService = repositoryService
        fetchRepos()
    }

    func getCellViewModel(indexPath: IndexPath) -> ViewModelProtocol? {
        guard repoList.indices.contains(indexPath.row) else {
            return nil
        }
        
        let repo = repoList[indexPath.row]
        let viewModel = RepoCellViewModel(repo: repo)
        return viewModel
    }
    
    private func fetchRepos() {
        repositoryService.getUserReposPublisher(endpoint: .repos(matching: username))
            .sink { completion in
                switch completion {
                case .failure(let error):
                    debugPrint("‼️ Error: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] respos in
                self?.repoList = respos
            }
            .store(in: &cancellables)
    }
}

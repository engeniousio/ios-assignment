//
//  RootViewModel.swift
//  engenious-challenge
//
//  Created by Eugene Fozekosh on 14.02.2024.
//

import Foundation
import Combine

class RepoListViewModel {
    private(set) var sectionTitle = "Repositories"
    private(set) var username = "apple" // empty state- stonean

    private var cancellables = Set<AnyCancellable>()
    private let repositoryService: RepositoryService

    @Published var repoList = [Repo]()
    @Published private(set) var viewControllerTitle: String
    @Published var errorMessage: String?

    var useCombine: Bool = false

    init(repositoryService: RepositoryService) {
        self.repositoryService = repositoryService
        viewControllerTitle = "\(username)'s repos"

        fetchRepos()
    }
    
    func fetchRepos() {
        if useCombine {
            // Combine approach
            repositoryService.getUserRepos(username: username)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                    }
                }, receiveValue: { [weak self] repos in
                    self?.repoList = repos
                })
                .store(in: &cancellables)
        } else {
            // Non-Combine approach
            repositoryService.getUserRepos(username: username) { [weak self] repos in
                DispatchQueue.main.async {
                    self?.repoList = repos
                }
            }
        }
    }
}

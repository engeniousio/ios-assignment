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
    private(set) var username = "apple" // Default username; consider allowing this to be set dynamically for more flexibility.

    private var cancellables = Set<AnyCancellable>()
    private let repositoryService: RepositoryService

    @Published var repoList = [Repo]()
    @Published private(set) var viewControllerTitle: String
    @Published var errorMessage: String?

    @Published var searchTerm: String? {
        didSet {
            searchForRepos()
        }
    }
    @Published var originalRepoList = [Repo]()

    var useCombine: Bool = true

    init(repositoryService: RepositoryService) {
        self.repositoryService = repositoryService
        viewControllerTitle = "\(username)'s repos"
        fetchRepos()
    }

    private func searchForRepos() {
        guard let searchTerm = searchTerm, !searchTerm.isEmpty else {
            repoList = originalRepoList
            return
        }
        repoList = originalRepoList.filter { $0.name.lowercased().contains(searchTerm.lowercased()) }
    }

    func fetchRepos() {
        if useCombine {
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
                    self?.originalRepoList = repos
                    self?.repoList = repos
                })
                .store(in: &cancellables)
        } else {
            // Non-Combine approach
            repositoryService.getUserRepos(username: username) { [weak self] repos in
                DispatchQueue.main.async {
                    self?.repoList = repos
                    self?.originalRepoList = repos
                }
            }
        }
    }
}

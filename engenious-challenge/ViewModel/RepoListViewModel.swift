//
//  RootViewModel.swift
//  engenious-challenge
//
//  Created by Eugene Fozekosh on 14.02.2024.
//

import Foundation
import Combine

class RepoListViewModel {
    @Published var repoList = [Repo]()
    private var cancellables = Set<AnyCancellable>()
    private let repositoryService = RepositoryService()

    // Error handling
    @Published var errorMessage: String?
    var useCombine: Bool = true

    func fetchRepos(username: String) {
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

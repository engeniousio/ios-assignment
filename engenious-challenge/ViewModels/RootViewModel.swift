//
//  RootViewModel.swift
//  engenious-challenge
//
//  Created by Oleg Granchenko on 31.01.2024.
//

import Foundation
import Combine

final class RootViewModel {

    private var repositoryService: RepositoryServiceProtocol
    private var repoList: [Repo] = []
    private(set) var error: RepositoryService.ServiceError?
    var cancellables: Set<AnyCancellable> = []

    init(repositoryService: RepositoryServiceProtocol = RepositoryService()) {
        self.repositoryService = repositoryService
    }

    var numberOfRepos: Int {
        return repoList.count
    }

    func repo(at index: Int) -> Repo {
        return repoList[index]
    }

    func fetchRepos(for username: String, completion: @escaping () -> Void) {
        repositoryService.getUserRepos(username: username) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let value):
                self.repoList = value
                self.error = nil

            case .failure(let error):
                self.repoList = [] // Reset repoList on failure
                self.error = error
            }
            completion()
        }
    }

    func fetchReposCombine(for username: String, completion: @escaping (Result<[Repo], RepositoryService.ServiceError>) -> Void) {
        repositoryService.getUserReposCombine(username: username)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] receivedCompletion in
                guard let self = self else { return }

                switch receivedCompletion {
                case .finished:
                    // Do nothing on success, as we already update the repoList within the publisher pipeline
                    break
                case .failure(let error):
                    self.repoList = [] // Reset repoList on failure
                    self.error = error
                    completion(.failure(error))
                }
            } receiveValue: { [weak self] repos in
                guard let self = self else { return }
                self.repoList = repos
                self.error = nil
                completion(.success(repos))
            }
            .store(in: &cancellables)
    }
    
}

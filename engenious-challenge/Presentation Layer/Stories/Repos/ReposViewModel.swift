//
//  ReposViewModel.swift
//  engenious-challenge
//
//  Created by admin on 14.01.2024.
//

import Foundation
import Combine

final class ReposViewModel: ReposViewModelProtocol {
    
    // MARK: - Constants
    
    private enum Constants {
        static let username: String = "Apple"
    }
    // MARK: - Properties(public)
    
    var selectedCategoryPublisher: Published<[Repo]>.Publisher { $repoList }
    
    // MARK: - Publishers
    
    @Published var repoList: [Repo] = []

    // MARK: - Properties(private)

    private let repositoryService: NetworkService = NetworkService()
    var storage = Set<AnyCancellable>()
    
    // MARK: - Init

    init() {
        /// uncomment to receive Response without Combine
//        getRepos()
        
        
        getReposWithCombine()
    }
    
    // MARK: - Methods(private)
    
    private func getRepos() {
        repositoryService.getUserRepos(username: Constants.username) { value in
            self.repoList = value
        }
    }
    
    private func getReposWithCombine() {
        repositoryService.getUserRepos(username: Constants.username)
            .sink(receiveCompletion: {completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            },
                  receiveValue: { [weak self] value in
                self?.repoList = value
            })
            .store(in: &storage)
    }
}

//
//  RepositoryListViewModel.swift
//  engenious-challenge
//
//  Created by Volodymyr Mykhailiuk on 09.02.2024.
//

import Foundation
import Combine

final class RepositoryListViewModel {
    enum State: Equatable {
        /// Initial state
        case initial
        /// The state used to indicate that reload is from refresh control
        case refreshing
        /// The state used to indicate that reload this is initial reload or reload from retry
        /// You should show activiti indicator in this case
        case loading
        /// The state used to indicate that data loaded
        ///`[RepoCellViewModel]` - list of models with information about repository
        case loaded([RepoCellViewModel])
        /// The state used to indicate that loading failed
        ///`ApiError` - type that represents error received from `NetworkLayer`
        case failed(ApiError)
    }
    
    // MARK: - Properties
    @Published private(set) var navigationTitle = ""
    @Published private(set) var listState: State = .initial
    
    let username: String = "Apple"
    private let repositoryService: RepositoryServiceProtocol
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    init(repositoryService: RepositoryServiceProtocol) {
        self.repositoryService = repositoryService
    }
    
    // MARK: - Public
    func setup() {
        navigationTitle = "\(username)'s repos"
        listState = .loading
        loadRepos()
    }
    
    func refresh(refreshControl: Bool) {
        listState = refreshControl ? .refreshing : .loading
        loadRepos()
    }
    
    // MARK: - Private
    private func loadRepos() {
        repositoryService.getUserRepos(username: username)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    self.listState = .failed(error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] in
                guard let self else { return }
                self.listState = .loaded($0.map(RepoCellViewModel.init))
            })
            .store(in: &cancellable)
    }
}

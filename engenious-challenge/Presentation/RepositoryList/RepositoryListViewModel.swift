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
        case initial
        case loading
        case loaded([RepoCellViewModel])
        case failed(ApiError)
    }
    
    private let username: String = "Apple"
    private let repositoryService: RepositoryServiceProtocol
    
    @Published private(set) var navigationTitle = ""
    @Published private(set) var listState: State = .initial
    
    private var cancellable = Set<AnyCancellable>()
    
    init(repositoryService: RepositoryServiceProtocol = RepositoryService()) {
        self.repositoryService = repositoryService
    }
    
    func setup() {
        navigationTitle = "\(username)'s repos"
        listState = .loading
        
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

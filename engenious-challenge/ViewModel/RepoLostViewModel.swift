//
//  RootViewModel.swift
//  engenious-challenge
//
//  Created by Misha Dovhiy on 08.01.2024.
//

import Foundation

protocol RepoLostViewModelPresenter {
    var apiError:NetworkService.APIError? { get set }
    func requestCompleted()
}

class RepoLostViewModel {
    private let repositoryService: RepositoryService = RepositoryService()
    let username: String = "Apple"
    var repoList: [Repository] = []
    
    var presenter:RepoLostViewModelPresenter
    
    init(presenter:RepoLostViewModelPresenter) {
        self.presenter = presenter
        NetworkPublisher.response.sink {
            guard let data = $0.data as? [Repository] else {
                self.presenter.apiError = $0.error ?? .emptyResponse
                self.presenter.requestCompleted()
                return
            }
            self.repoList = data
            self.presenter.apiError = $0.error
            self.presenter.requestCompleted()
        }.store(in: &NetworkPublisher.cancellableHolder)
    }
    
    func getRepositories() {
        presenter.apiError = nil
        repositoryService.fetchRepositories(username: username)
    }
    
    var navigationTitle:String {
        return "\(username)'s repos"
    }
}

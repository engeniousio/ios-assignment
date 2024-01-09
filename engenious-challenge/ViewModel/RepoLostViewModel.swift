//
//  RootViewModel.swift
//  engenious-challenge
//
//  Created by Misha Dovhiy on 08.01.2024.
//

import Foundation

class RepoLostViewModel {
    
    private let repositoryService: RepositoryService = RepositoryService()
    let username: String = "Apple"
    let sectionTitle:String = "Repositories"
    var repoList: [Repository] = []
    
    var presenter:RepoLostViewModelPresenter
    
    init(presenter:RepoLostViewModelPresenter) {
        self.presenter = presenter
        NetworkPublisher.response.sink {
            self.responseUpdated($0)
        }.store(in: &NetworkPublisher.cancellableHolder)
    }
    
    func getRepositories() {
        presenter.apiError = nil
        repositoryService.fetchRepositories(username: username)
    }
    
    var navigationTitle:String {
        return "\(username)'s repos"
    }
    
    private func responseUpdated(_ response:ServerResponse) {
        guard let data = response.data as? [Repository] else {
            presenter.apiError = response.error ?? .emptyResponse
            presenter.requestCompleted()
            return
        }
        repoList = data
        presenter.apiError = response.error
        presenter.requestCompleted()
    }
}

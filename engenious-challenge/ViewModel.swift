//
//  ViewModel.swift
//  engenious-challenge
//
//  Created by Sofia Gorlata on 22.11.2023.
//

import Foundation

class ViewModel {
    private let repositoryService: RepositoryService = RepositoryService()
    let username: String = "Apple"
    var repoList: [Repo] = []
    weak var view: RootView?
    
    func getRepos() {
        repositoryService.getUserRepos(username: username) { [weak self] value in
            DispatchQueue.main.async {
                self?.repoList = value
                self?.view?.updateView()
            }
        }
    }
}

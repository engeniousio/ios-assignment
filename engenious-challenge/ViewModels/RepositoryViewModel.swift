//
//  RepoViewModel.swift
//  engenious-challenge
//
//  Created by Никита Бабанин on 15/01/2024.
//

import Foundation
import Combine

protocol RepositoryViewModelProtocol {
    var repoList: [RepositoryModel] { get } 
    func getRepos(username: String, reloadCompletion: @escaping () -> Void)
}

final class RepositoryViewModel: RepositoryViewModelProtocol {
    private let repositoryService: RepositoryServiceProtocol?
    var repoList: [RepositoryModel] = []
    
    init(repositoryService: RepositoryServiceProtocol?) {
        self.repositoryService = repositoryService
    }
    
    func getRepos(username: String, reloadCompletion: @escaping () -> Void) {
        repositoryService?.getUserRepos(username: username, completion: { [weak self] result in
            do {
                self?.repoList = try result.get()
            } catch {
                print(error)
            }
            
            reloadCompletion()
        })
    }
}

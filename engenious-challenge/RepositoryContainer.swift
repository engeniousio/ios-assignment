//
//  Repo.swift
//  engenious-challenge
//
//  Created by Никита Бабанин on 16/01/2024.
//

import UIKit

final class RepositoryContainer {
    func buildRepository() -> UIViewController {
        let repositoryService: RepositoryServiceProtocol = CombineRepositoryService()
        let viewModel: RepositoryViewModelProtocol = RepositoryViewModel(repositoryService: repositoryService)
        let viewController = RepositoryViewController(viewModel: viewModel)
        return viewController
    }
}

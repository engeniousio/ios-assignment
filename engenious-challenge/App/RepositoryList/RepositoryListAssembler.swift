//
//  RepositoryListAssembler.swift
//  engenious-challenge
//
//  Created by Volodymyr Mykhailiuk on 11.02.2024.
//

import UIKit

enum RepositoryListAssembler {
    /// Assemble and set all dependencies for RepositoryListViewController
    /// returns `UIViewController`
    static func assembleModule() -> UIViewController {
        let networkLayer = NetworkLayer(urlsession: URLSession.shared)
        let repo = RepositoryService(networkLayer: networkLayer)
        let vm = RepositoryListViewModel(repositoryService: repo)
        return RepositoryListViewController(viewModel: vm)
    }
}

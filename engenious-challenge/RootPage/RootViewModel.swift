//
//  RootViewModel.swift
//  engenious-challenge
//
//  Created by Mikita Dzmitrievich on 7.09.23.
//

import Combine

final class RootViewModel {
    
    @Published private(set) var pageTitle: String
    @Published private(set) var isLoading: Bool
    
    let dataSource: RepoListDataSource
    private let networkService: NetworkService
    private let username: String //= "Apple"
    
    init(networkService: NetworkService, username: String) {
        self.username = username
        self.networkService = networkService
        self.dataSource = .init(with: [])
        isLoading = false
        pageTitle = Self.pageTitle(for: username)
    }
    
    private static func pageTitle(for username: String) -> String {
        "\(username)'s repos"
    }

    func fetchRepos() {
        Task { [weak self] in
            guard let self else { return }
            self.isLoading = true
            do {
                let result = try await self.networkService.userRepos(with: username)
                await self.dataSource.updateCellModels(to: result.map { RepoCellModel(data: $0) })
            } catch {
                // print some error if needed
            }
            self.isLoading = false
        }
    }
}

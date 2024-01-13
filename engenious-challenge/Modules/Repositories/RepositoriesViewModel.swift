//
//  DashboardViewModel.swift
//  engenious-challenge
//
//  Created by Юлія Воротченко on 10.01.2024.
//

import Foundation
import Combine

protocol RepositoriesViewModelInputs {
    func getRepositories()
}

protocol RepositoriesViewModelOutputs {
    var navigateToSomewhere: PassthroughSubject<Void, Never> { get }
}

protocol RepositoriesViewModelProtocol {
    var inputs: RepositoriesViewModelInputs { get set }
    var outputs: RepositoriesViewModelOutputs { get }
}

// MARK: - ViewModel
final class RepositoriesViewModel: BaseViewModel,
                                   RepositoriesViewModelProtocol,
                                   RepositoriesViewModelInputs,
                                   RepositoriesViewModelOutputs {
   
    var inputs: RepositoriesViewModelInputs {
        get {
            return self
        }
        set {}
    }
    
    var outputs: RepositoriesViewModelOutputs {
        return self
    }
   
    private var repositorysService: RepositoryServiceProtocol
   
    init(repositorysService: RepositoryServiceProtocol = RepositoryService()) {
        self.repositorysService = repositorysService
    }
    
    @Published var repositories: [Repository] = []
    
    // MARK: - Outputs
    var navigateToSomewhere = PassthroughSubject<Void, Never>()
    
   
    // MARK: - Inputs
    func getRepositories() {
        isLoading.send(true)
        let repositoryDTO: RepositoryDTO = .init(username: "Apple")
        
        self.repositorysService.repositories(request: repositoryDTO)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading.send(false)
                switch completion {
                case .failure(let error):
                    self.displayMessage.send(error.localizedDescription)
                case .finished:
                    printIfDebug("Repos load finished")
                }
            } receiveValue: { repositoriesResponse in
                self.repositories = repositoriesResponse
            }.store(in: &cancellable)
    }
}

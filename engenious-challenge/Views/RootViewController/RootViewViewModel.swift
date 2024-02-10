//
//  RootViewViewModel.swift
//  engenious-challenge
//
//  Created by Eugene Garkavenko on 10.02.2024.
//

import Foundation
import Combine
import UIKit

final class RootViewViewModel {
    private let services: Services
    let userName: String
    
    private(set) var items: CurrentValueSubject<[Repo], Never> = CurrentValueSubject([])
    private(set) var isLoading: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false) // Can be used for loading indication
    private(set) var errorMessage: CurrentValueSubject<String?, Never> = CurrentValueSubject(nil) // Can be used to display or log an error
    
    private var cancellablesBag = Set<AnyCancellable>()
    
    init(services: Services, userName: String) {
        self.services = services
        self.userName = userName
    }
    
    func getReposCellViewModelBy(index: Int) -> RepoTableViewCellViewModel {
        RepoTableViewCellViewModel(model: items.value[index])
    }
}

extension RootViewViewModel {
    func loadDataCombine() {
        guard let url = Endpoint.usersRepos(username: userName).url else {
            return
        }
        isLoading.send(true)
        services
            .networkServiceCombine
            .fetchData(with: url)
            .tryMap { [weak self] in
                guard let httpResponse = $0.response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    self?.isLoading.send(false)
                    self?.errorMessage.send("Bad Server Response")
                    throw URLError(.badServerResponse)
                }
                return $0.data
            }
            .decode(type: [Repo].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] in
                self?.isLoading.send(false)
                switch $0 {
                case .failure(let error):
                    self?.errorMessage.send(error.localizedDescription)
                    break
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] in
                self?.items.send($0)
            })
            .store(in: &cancellablesBag)
    }
}

extension RootViewViewModel {
    func loadDataCallback() {
        guard let url = Endpoint.usersRepos(username: userName).url else {
            return
        }
        isLoading.send(true)
        services
            .networkServiceCallback.fetchData(with: url) { [weak self] result in
            self?.isLoading.send(false)
            switch result {
            case .success(let (response, data)):
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    self?.errorMessage.send("Bad Server Response")
                    return
                }
                
                do {
                    let repos = try JSONDecoder().decode([Repo].self, from: data)
                    self?.items.send(repos)
                } catch {
                    self?.errorMessage.send("Error decode object")
                }
                
            case .failure(let error):
                self?.errorMessage.send(error.localizedDescription)
            }
        }
    }
}

import Foundation

// MARK: - RootViewModelProtocol

protocol RootViewModelProtocol {
    
    var repoList: [Repo] { get }
    var displayUsername: String { get }
    
    init(repositoryService: RepositoryServiceProtocol)
    
    func getRepos(completion: @escaping () -> Void)
}

// MARK: - RootViewModel

final class RootViewModel {
    
    // MARK: - Properties
    
    var repoList: [Repo] = []
    private let repositoryService: RepositoryServiceProtocol
    private let username: String = "Apple"
    
    var displayUsername: String {
        "\(username)'s repos"
    }
    
    // MARK: - Init
    
    required init(repositoryService: RepositoryServiceProtocol) {
        
        self.repositoryService = repositoryService
    }
}

// MARK: - RootViewModelProtocol

extension RootViewModel: RootViewModelProtocol {
    
    func getRepos(completion: @escaping () -> Void) {
        repositoryService.getUserRepos(username: username) { result in
            DispatchQueue.main.async { [weak self] in
                self?.repoList = result
                completion()
            }
        }
    }
}

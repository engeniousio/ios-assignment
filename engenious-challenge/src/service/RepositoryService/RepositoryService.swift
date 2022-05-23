import Foundation
import Combine

// MARK: - RepositoryService

struct RepositoryService {
    
    private let urlService: URLServiceProtocol
    
    init(urlService: URLServiceProtocol) {
        self.urlService = urlService
    }
}

// MARK: - RepositoryServiceProtocol

extension RepositoryService: RepositoryServiceProtocol {
    
    func getUserRepos(username: String, completion: @escaping ([Repo]) -> Void) {
        guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else {
            return completion([])
        }
        
        let request = URLRequest(url: url)
        
        urlService.makeRequest(with: request, responseType: [Repo].self, completion: completion)
    }
}

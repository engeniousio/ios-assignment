import Combine

// MARK: - RepositoryCombineService

class RepositoryCombineService {
    
    private var userReposCancellable: AnyCancellable?
    private let urlService: URLServiceProtocol
    
    required init(urlService: URLServiceProtocol) {
        self.urlService = urlService
    }
}

// MARK: - RepositoryServiceProtocol

extension RepositoryCombineService: RepositoryServiceProtocol {
    
    func getUserRepos(username: String, completion: @escaping ([Repo]) -> Void) {
        userReposCancellable = UserReposRequest(username: username)
            .execute(urlService: urlService)
            .sink(receiveCompletion: { subscribers in
                print(subscribers)
            }, receiveValue: { repos in
                completion(repos)
            })
    }
}

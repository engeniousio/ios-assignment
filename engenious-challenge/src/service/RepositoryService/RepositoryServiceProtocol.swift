// MARK: - RepositoryServiceProtocol

protocol RepositoryServiceProtocol {
    
    init(urlService: URLServiceProtocol)
    
    /// - Parameter username: specify github username
    /// - Parameter completion: called when request was executed with result as `[Repo]`
    func getUserRepos(username: String, completion: @escaping ([Repo]) -> Void)
}

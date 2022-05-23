// MARK: - UserReposRequest

struct UserReposRequest: Requestable {
    
    typealias ResponseType = [Repo]
    
    var path: String
    
    init(username: String) {
        path = "/users/\(username)/repos"
    }
}

import Foundation
import Combine

// MARK: - Requestable

protocol Requestable {
    
    associatedtype ResponseType: Decodable
    
    var path: String { get }
    
    func execute(urlService: URLServiceProtocol) -> RequestPublisher<ResponseType>
}

extension Requestable {
    
    static var basePath: String {
        return "https://api.github.com"
    }
    
    func execute(urlService: URLServiceProtocol) -> RequestPublisher<ResponseType> {
        
        let url = URL(string: Self.basePath + path)!
        
        return urlService.makeRequest(
            with: URLRequest(url: url),
            responseType: ResponseType.self
        )
    }
}

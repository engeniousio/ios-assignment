import Foundation
import Combine
@testable import engenious_challenge

class URLServiceMock: URLServiceProtocol {
    
    // MARK: -
    
    private(set) var makeRequestInvoked: Bool = false
    
    func makeRequest<T>(with urlRequest: URLRequest,
                        responseType: T.Type,
                        completion: @escaping (T) -> Void
    ) where T : Decodable {
        makeRequestInvoked = true
    }
    
    // MARK: -
    
    private(set) var makeRequestPublisherInvoked: Bool = false
    
    func makeRequest<T>(
        with urlRequest: URLRequest,
        responseType: T.Type
    ) -> RequestPublisher<T> where T : Decodable {
        makeRequestPublisherInvoked = true
        return Empty().eraseToAnyPublisher()
    }
}

import Combine
import Foundation

// MARK: - RequestPublisher

typealias RequestPublisher<T: Decodable> = AnyPublisher<T, Error>

// MARK: - URLServiceProtocol

protocol URLServiceProtocol {
    
    func makeRequest<T: Decodable>(
        with urlRequest: URLRequest,
        responseType: T.Type,
        completion: @escaping (T) -> Void
    )
    
    func makeRequest<T: Decodable>(
        with urlRequest: URLRequest,
        responseType: T.Type
    ) -> RequestPublisher<T>
}

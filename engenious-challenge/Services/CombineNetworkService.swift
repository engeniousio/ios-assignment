//
//  CombineRepositoryService.swift
//  engenious-challenge
//
//  Created by Oleg Granchenko on 31.01.2024.
//

import Foundation
import Combine

class CombineRepositoryService {

    enum NetworkError: Error {
        case invalidURL
        case networkError(Error)
        case decodingError(Error)
    }

    static func fetchData<T: Decodable>(_ type: T.Type, from urlString: String) -> AnyPublisher<T, NetworkError> {
        guard let url = URL(string: urlString) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { NetworkError.networkError($0) }
            .flatMap { data, response in
                return Just(data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError { NetworkError.decodingError($0) }
            }
            .eraseToAnyPublisher()
    }
}


//
//  APIClient.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import Foundation

struct APIClient {
    
    enum CustomError: Error {
        case incorrectUrl
        case missedData
    }
    
    let host: String
    let session: URLSession
    
    static let shared = APIClient()
    
    private init() {
        // some settings here
        host = "https://api.github.com"
        session = URLSession.shared
    }
    
    func performRequest<T: Decodable>(path: String) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            guard let url = URL(string: host + path) else {
                continuation.resume(throwing: CustomError.incorrectUrl)
                return
            }
            let request = URLRequest(url: url)
            session.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let data = data else {
                    continuation.resume(throwing: CustomError.missedData)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(T.self, from: data)
                    continuation.resume(returning: result)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
            .resume()
        }
    }
}

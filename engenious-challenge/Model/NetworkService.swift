//
//  NetworkService.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import Foundation

struct NetworkService {
    private let baseURL:String = "https://api.github.com"
    
    func request(endpoint:Endpoint, parameters:String) async -> ServerResponse {
        
        let urlString = baseURL + endpoint.prefix +  parameters + endpoint.path
        guard let url = URL(string: urlString) else {
            return .error(.invalidURL)
        }
        
        let session = URLSession.shared
        let request = URLRequest(url: url)
        do {
            let task = try await session.data(for: .init(url: url))
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode([Repository].self, from: task.0)
                return .success(response)
            } catch let error {
                return .error(.requestFailed(error.localizedDescription))
            }
        } catch let error {
            return .error(.requestFailed(error.localizedDescription))
        }
    }
}


extension NetworkService {
    enum APIError:Error {
        case invalidURL
        case decode
        case emptyResponse
        case requestFailed(_ error: String)
    }
    
    enum Endpoint {
        case repositories
        
        var path:String {
            switch self {
            case .repositories:
                return "/repos"
            }
        }
        
        var prefix:String {
            switch self {
            case .repositories:
                return "/users/"
            }
        }
    }
    
    struct ServerResponse {
        var data:Codable? = nil
        var error:APIError? = nil
        
        static func error(_ error:APIError) -> ServerResponse {
            return .init(error: error)
        }
        
        static func success(_ data:Codable) -> ServerResponse {
            return .init(data: data)
        }
    }
}

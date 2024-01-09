//
//  NetworkService.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import Foundation

struct NetworkService {
    
    private let baseURL:String = "https://api.github.com"
    
    func request(endpoint:Endpoint, parameters:String, offline:Bool = false) async -> ServerResponse {
        
        let urlString = baseURL + endpoint.prefix +  parameters + endpoint.path
        guard let url = URL(string: urlString) else {
            return .error(.invalidURL)
        }
        
        do {
            let task = try await URLSession.shared.data(for: .init(url: url, cachePolicy: offline ? .returnCacheDataDontLoad : .reloadIgnoringLocalCacheData))
            return await unparceResponse(task: task)
        } catch let error {
            if offline {
                return .error(.requestFailed(error.localizedDescription))
            } else {
                return await request(endpoint: endpoint, parameters: parameters, offline: true)
            }
        }
    }
    
    private func unparceResponse(task: (Data, URLResponse)) async -> ServerResponse {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode([Repository].self, from: task.0)
            return .success(response)
        } catch let error {
            return .error(.requestFailed(error.localizedDescription))
        }
    }
}


extension NetworkService {
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
}

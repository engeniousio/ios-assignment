//
//  File.swift
//  engenious-challenge
//
//  Created by Юлія Воротченко on 11.01.2024.
//

import Foundation

enum Endpoints {
    
    case getUsersRepos(request: RepositoryDTO)
    
    private var baseURL: String {
        return AppConfiguration().apiBaseURL
    }
    
    private var requestTimeOut: Int {
        return 30
    }
        
    private var path: String {
        switch self {
        case .getUsersRepos(let userDTO):
            return "users/\(userDTO.username)/repos"
        }
    }
    
    private var httpMethod: HTTPMethod {
        switch self {
        case .getUsersRepos:
            return .GET
        }
    }
    
    private var requestBody: Encodable? {
        switch self {
        case .getUsersRepos:
            return nil
        }
    }
    
    private func getURL() -> String {
        return self.baseURL + self.path
    }
    
    func createRequest() -> NetworkRequest {
        printIfDebug("request: \(getURL())")
        printIfDebug("method: \(httpMethod)")
        
        return NetworkRequest(url: getURL(),
                              headers: AppConfiguration().headers,
                              reqBody: nil,
                              httpMethod: httpMethod)
    }
}


//
//  File.swift
//  engenious-challenge
//
//  Created by Юлія Воротченко on 11.01.2024.
//

import Foundation

enum Endpoints {
    
    case getUserRepos(request: RepositoryDTO)
    
    private var baseURL: String {
        return AppConfiguration().apiBaseURL
    }
    
    private var requestTimeOut: Int {
        return 30
    }
        
    private var path: String {
        switch self {
        case .getUserRepos(let username):
            return "users/\(username)/repos"
        }
    }
    
    private var httpMethod: HTTPMethod {
        switch self {
        case .getUserRepos:
            return .GET
        }
    }
    
    private var requestBody: Encodable? {
        switch self {
        case .getUserRepos(let request):
            return request
        }
    }
    
    private func getURL() -> String {
        return self.baseURL + self.path
    }
    
    func createRequest() -> NetworkRequest {
        printIfDebug("request: \(getURL())")
        printIfDebug("method: \(httpMethod)")
        printIfDebug("body: \(requestBody ?? "")")
        
        return NetworkRequest(url: getURL(),
                              headers: AppConfiguration().headers,
                              reqBody: requestBody,
                              httpMethod: httpMethod)
    }

}


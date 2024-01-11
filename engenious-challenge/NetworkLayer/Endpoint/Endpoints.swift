//
//  File.swift
//  engenious-challenge
//
//  Created by Юлія Воротченко on 11.01.2024.
//

import Foundation

enum Endpoints {
    
    case getUserRepos(request: RepositoryDTO)
    
    var baseURL: String {
        return AppConfiguration().apiBaseURL
    }
    
    var requestTimeOut: Int {
        return 30
    }
        
    var path: String {
        switch self {
        case .getUserRepos(let username):
            return "users/\(username)/repos"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getUserRepos:
            return .GET
        }
    }
    
    var requestBody: Encodable? {
        switch self {
        case .getUserRepos(let request):
            return request
        }
    }
    
    func getURL() -> String {
        return self.baseURL + self.path
    }
    
    func createRequest() -> NetworkRequest {
        
        debugPrint("request: \(getURL())")
        debugPrint("method: \(httpMethod)")
        debugPrint("body: \(requestBody ?? "")")
        
        return NetworkRequest(url: getURL(),
                              headers: AppConfiguration().headers,
                              reqBody: requestBody,
                              httpMethod: httpMethod)
    }

}


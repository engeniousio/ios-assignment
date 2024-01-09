//
//  ServerResponse.swift
//  engenious-challenge
//
//  Created by Misha Dovhiy on 09.01.2024.
//

import Foundation

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

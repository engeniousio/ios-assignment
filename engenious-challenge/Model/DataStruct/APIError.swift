//
//  APIError.swift
//  engenious-challenge
//
//  Created by Misha Dovhiy on 09.01.2024.
//

import Foundation

enum APIError:Error {
    case invalidURL
    case decode
    case emptyResponse
    case requestFailed(_ error: String)
    
    var message:Message {
        switch self {
        case .invalidURL:
            return .init(title: "Invalide URL")
        case .decode:
            return .init(title: "Error decoding data")
        case .emptyResponse:
            return .init(title: "No Response")
        case .requestFailed(let error):
            return .init(title: error)
        }
    }
}

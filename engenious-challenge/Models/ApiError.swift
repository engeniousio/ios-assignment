//
//  ApiError.swift
//  engenious-challenge
//
//  Created by Volodymyr Mykhailiuk on 10.02.2024.
//

import Foundation

enum ApiError: Error {
    case invalidURL
    case decodingError(Error)
    case networkError(Error)
    case emptyResponse
    case invalidResponse
    case httpError(Int)
    
}

extension ApiError: Equatable {
    static func == (lhs: ApiError, rhs: ApiError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case let (.decodingError(lhsError), .decodingError(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case let (.networkError(lhsError), .networkError(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.emptyResponse, .emptyResponse):
            return true
        case (.invalidResponse, .invalidResponse):
            return true
        case let (.httpError(lhsCode), .httpError(rhsCode)):
            return lhsCode == rhsCode
        default:
            return false
        }
    }
}

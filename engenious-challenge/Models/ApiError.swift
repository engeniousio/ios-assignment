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
    
    var alertTitle: String {
        switch self {
        case .invalidURL, .decodingError, .emptyResponse, .invalidResponse:
            return "Oops!"
        case .networkError:
            return "Connection Issue"
        case .httpError:
            return "Server Error"
        }
    }
    
    var alertMessage: String {
        switch self {
        case .invalidURL:
            return "The provided URL is not valid. Please check and try again."
        case .decodingError:
            return "There was an issue decoding the data received from the server. Please try again later."
        case .networkError(let error):
            return "There seems to be a problem with your internet connection. Please check your connection and try again. Details: \(error.localizedDescription)"
        case .emptyResponse:
            return "No data was received from the server. Please try again later."
        case .invalidResponse:
            return "The server responded with invalid data. Please try again later."
        case .httpError(let statusCode):
            return "Oops! Something went wrong with the server. Status code: \(statusCode)"
        }
    }
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

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
}

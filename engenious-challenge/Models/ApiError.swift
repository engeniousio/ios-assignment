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
}

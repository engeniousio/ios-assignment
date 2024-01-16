//
//  ErrorTypes.swift
//  engenious-challenge
//
//  Created by Никита Бабанин on 16/01/2024.
//

import Foundation

enum ErrorTypes: Error, Equatable {
    case invalidURL(_ error: String)
    case failureResponse(_ error: String)
}

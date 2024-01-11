//
//  AppConfiguration.swift
//  engenious-challenge
//
//  Created by Юлія Воротченко on 11.01.2024.
//

import Foundation

final class AppConfiguration {
        
    lazy var apiBaseURL: String = {
        return "https://api.github.com/"
    }()
    
    lazy var headers: [String: String] = {
        let headers: [String: String] = [
            "Content-Type": "application/json"
        ]
        return headers
    }()
}

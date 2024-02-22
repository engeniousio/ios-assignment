//
//  Endpoint.swift
//  engenious-challenge
//
//  Created by Pavlo on 22.02.2024.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

enum EndpointError: Error {
    case invalidURL
    case network(Error?)
    case invalidResponse(URLResponse?)
    case invalidData
    case validation(Error)
}

extension Endpoint {
    static func repos(matching username: String) -> Endpoint {
        return Endpoint(
            path: "/users/\(username)/repos",
            queryItems: []
        )
    }
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}

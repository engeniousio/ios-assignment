//
//  Endpoints.swift
//  engenious-challenge
//
//  Created by Eugene Garkavenko on 10.02.2024.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "api.github.com"
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}

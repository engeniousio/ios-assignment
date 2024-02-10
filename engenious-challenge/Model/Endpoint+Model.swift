//
//  Endpoint+Model.swift
//  engenious-challenge
//
//  Created by Eugene Garkavenko on 10.02.2024.
//

import Foundation

import Foundation

extension Endpoint {
    static func usersRepos(username: String) -> Self {
        .init(path: "/users/\(username)/repos", queryItems: [])
    }
}

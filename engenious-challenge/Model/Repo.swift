//
//  Repo.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import Foundation

struct Repo: Codable {
    var name: String
    var description: String?
    var url: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case url = "url"
    }
}


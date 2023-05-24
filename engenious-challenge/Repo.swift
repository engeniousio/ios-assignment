//
//  Repo.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import Foundation

struct Repo: Codable {
	
    let name: String
    let description: String?
    let url: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case url = "url"
    }
}


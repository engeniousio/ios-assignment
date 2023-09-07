//
//  RepoModel.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import Foundation

struct RepoModel: Decodable {
    var url: String
    var name: String
    var description: String?
}

//
//  RepoTableViewCellViewModel.swift
//  engenious-challenge
//
//  Created by Eugene Garkavenko on 10.02.2024.
//

import Combine
import Foundation

struct RepoTableViewCellViewModel {
    let name: String
    let description: String?

    init(model: Repo) {
        name = model.name
        description = model.description
    }
}

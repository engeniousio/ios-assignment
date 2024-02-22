//
//  RepoCellViewModel.swift
//  engenious-challenge
//
//  Created by Pavlo on 22.02.2024.
//

import Foundation

final class RepoCellViewModel: ViewModelProtocol {
    private let repo: Repo
    
    var title: String {
        return repo.name
    }
    
    var subtitle: String? {
        return repo.description
    }
    
    init(repo: Repo) {
        self.repo = repo
    }
}

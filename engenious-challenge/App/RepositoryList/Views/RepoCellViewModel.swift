//
//  RepoCellViewModel.swift
//  engenious-challenge
//
//  Created by Volodymyr Mykhailiuk on 10.02.2024.
//

import Foundation

struct RepoCellViewModel {
    var name: String
    var description: String?
    var url: URL?
    
    init(dataModel: RepoDataModel) {
        self.name = dataModel.name
        self.description = dataModel.description
        self.url = URL(string: dataModel.url)
    }
}

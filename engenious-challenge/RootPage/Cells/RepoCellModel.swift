//
//  RepoCellModel.swift
//  engenious-challenge
//
//  Created by Mikita Dzmitrievich on 7.09.23.
//

import Combine

final class RepoCellModel: CellViewModel {
    
    @Published private(set) var title: String
    
    private var data: RepoModel
    
    init(data: RepoModel, cellIdentifier: String = RepoTableViewCell.cellIdentifier) {
        self.data = data
        title = data.name
        super.init(cellIdentifier: cellIdentifier)
    }
}

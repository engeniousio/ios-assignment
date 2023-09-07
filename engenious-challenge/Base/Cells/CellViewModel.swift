//
//  CellViewModel.swift
//  engenious-challenge
//
//  Created by Mikita Dzmitrievich on 7.09.23.
//

import Combine

class CellViewModel {
    
    let cellIdentifier: String
    
    weak var fillableCell: FillableCell? {
        didSet {
            fillableCell?.fill(by: self)
            bind(with: fillableCell)
        }
    }
    
    var subscriptions = Set<AnyCancellable>()
    
    init(cellIdentifier: String) {
        self.cellIdentifier = cellIdentifier
    }
    
    func bind(with fillableCell: FillableCell?) {
        // will override in childs
    }
}

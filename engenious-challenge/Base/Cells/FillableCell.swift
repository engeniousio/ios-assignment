//
//  FillableCell.swift
//  engenious-challenge
//
//  Created by Mikita Dzmitrievich on 7.09.23.
//

import Foundation

protocol FillableCell: AnyObject {
    func fill(by cellModel: CellViewModel)
}

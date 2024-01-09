//
//  ClearCell.swift
//  engenious-challenge
//
//  Created by Misha Dovhiy on 09.01.2024.
//

import UIKit

class ClearCell:UITableViewCell {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        backgroundColor = .clear
        setSelectedColor(.clear)
    }
}

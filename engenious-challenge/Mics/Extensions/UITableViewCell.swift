//
//  UITableViewCell.swift
//  engenious-challenge
//
//  Created by Misha Dovhiy on 09.01.2024.
//

import UIKit

extension UITableViewCell {
    func setSelectedColor(_ color:UIColor) {
        let selected = UIView(frame: .zero)
        selected.backgroundColor = color
        self.selectedBackgroundView = selected
    }
}

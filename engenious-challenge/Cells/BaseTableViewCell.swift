//
//  BaseTableViewCell.swift
//  engenious-challenge
//
//  Created by Pavlo on 22.02.2024.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
        
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        commonInit()
    }
    
    private func commonInit() {
        selectionStyle = .none
    }
}

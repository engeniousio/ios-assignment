//
//  MessageTableViewCell.swift
//  engenious-challenge
//
//  Created by Misha Dovhiy on 09.01.2024.
//

import UIKit

class MessageTableViewCell:ClearCell {
    
    private let titleLabel = UILabel()
    
    func set(title:String) {
        titleLabel.text = title
    }
    
    func set(message:Message) {
        self.set(title: message.title)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        titleLabel.addConstaits([.left:5, .right:5, .top:0, .bottom:0])
        titleLabel.textAlignment = .center
        titleLabel.textColor = K.Colors.description
        titleLabel.numberOfLines = 0
        titleLabel.font = AppearanceModel.Fonts.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

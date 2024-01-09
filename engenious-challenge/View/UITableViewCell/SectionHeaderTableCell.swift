//
//  SectionHeaderTableCell.swift
//  engenious-challenge
//
//  Created by Misha Dovhiy on 09.01.2024.
//

import UIKit

class SectionHeaderTableCell: UITableViewCell {
    
    let titleLabel:UILabel = .init()
    
    func set(title:String) {
        titleLabel.text = title
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let view = UIView()
        contentView.addSubview(view)
        view.addConstaits([.left:0, .right:0, .top:0, .bottom:0], toView: contentView)
        let _ = view.addBluer()
        view.addSubview(titleLabel)
        titleLabel.addConstaits([.left:AppStyles.containerMargins1, .right:AppStyles.containerMargins1, .top:AppStyles.containerMargins1 / 2, .bottom:-(AppStyles.containerMargins1 / 2)], toView: view)
        titleLabel.font = AppStyles.Fonts.section
        titleLabel.textColor = K.Colors.blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

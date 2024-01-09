//
//  SectionHeaderTableCell.swift
//  engenious-challenge
//
//  Created by Misha Dovhiy on 09.01.2024.
//

import UIKit

class SectionHeaderTableCell: UITableViewCell {
    
    private let titleLabel:UILabel = .init()
    
    func set(title:String) {
        titleLabel.text = title
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: Layer
fileprivate extension SectionHeaderTableCell {
    
    func loadUI() {
        addBackgroundView()
        setupUI()
    }
    
    func setupUI() {
        titleLabel.addConstaits([.left:AppStyles.containerMargins1, .right:AppStyles.containerMargins1, .top:AppStyles.containerMargins1 / 2, .bottom:-(AppStyles.containerMargins1 / 2)])
        titleLabel.font = AppStyles.Fonts.section
        titleLabel.textColor = K.Colors.blue
    }
    
    func addBackgroundView() {
        let view = UIView()
        contentView.addSubview(view)
        view.addConstaits([.left:0, .right:0, .top:0, .bottom:0])
        let _ = view.addBluer()
        view.backgroundColor = .white.withAlphaComponent(0.7)
        view.layer.shadow(color: UIColor.white.cgColor, opacity: 0.7)
        view.addSubview(titleLabel)
    }
}

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
        titleLabel.addConstaits([.left:AppearanceModel.containerMargins1, .right:AppearanceModel.containerMargins1, .top:AppearanceModel.containerMargins1 / 2, .bottom:-(AppearanceModel.containerMargins1 / 2)])
        titleLabel.font = AppearanceModel.Fonts.section
        titleLabel.textColor = K.Colors.blue
    }
    
    func addBackgroundView() {
        let view = UIView()
        contentView.addSubview(view)
        view.addConstaits([.left:0, .right:0, .top:0, .bottom:0])
        let _ = view.addBluer()
        view.backgroundColor = K.Colors.background.withAlphaComponent(0.7)
        view.layer.shadow(color:K.Colors.background.cgColor, opacity: 0.7)
        view.addSubview(titleLabel)
    }
}

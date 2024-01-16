//
//  RepositoryHeaderView.swift
//  engenious-challenge
//
//  Created by Никита Бабанин on 18/01/2024.
//

import UIKit

protocol RepositoryHeaderStyling {
    var headerLabelColor: UIColor { get }
    var headerLabelFont: UIFont { get }
}

final class RepositoryHeaderView: UIView, ControlSetup {
    private enum Consts {
        static let leadingInset: CGFloat = 16
        static let headerText = "Repositories"
    }
    private let headerLabel = UILabel()
    private let style: RepositoryHeaderStyling
    
    init(frame: CGRect, style: RepositoryHeaderStyling) {
        self.style = style
        super.init(frame: frame)
        controlSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        addSubview(headerLabel)
    }
    
    func setupAutoLayout() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Consts.leadingInset),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupStyle() {
        headerLabel.text = Consts.headerText
        headerLabel.font = style.headerLabelFont
        headerLabel.textColor = style.headerLabelColor
    }
}

//
//  TableViewHeader.swift
//  engenious-challenge
//
//  Created by admin on 14.01.2024.
//

import UIKit

final class TableViewHeader: UIView {
    
    // MARK: - Constants

    private enum Constants {
        static let topConstraint: CGFloat = 8
        static let leadingConstraint: CGFloat = 18
        static let fontSize: CGFloat = 20
    }
    
    // MARK: - Properties(public)

    let titleLabel: UILabel = .init()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupTitleLabel()
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.topConstraint).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingConstraint).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods(private)

    private func setupTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: Constants.fontSize, weight: .bold)
        titleLabel.textColor = UIColor.titleColor
    }
}

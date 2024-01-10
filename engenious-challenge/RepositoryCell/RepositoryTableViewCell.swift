//
//  RepoTableViewCell.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .listTitleColor
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    var captionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .cellTextColor
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, captionLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    private let gradientLayer = CAGradientLayer()
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        self.gradientLayer.frame = self.bounds
        let colorSet = [
            UIColor.cellGradientStartColor,
            UIColor.cellGradientEndColor
        ]
        let location = [0.156, 0.9084]
        self.contentView.addBackgroundGradient(with: gradientLayer, colorSet: colorSet, locations: location)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




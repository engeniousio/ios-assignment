//
//  RepoTableViewCell.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    private let gradientLabelsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    private lazy var labelsStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, captionLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    private let gradientLayer = CAGradientLayer()
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.gradientLabelsContainer.layer)
        self.gradientLayer.frame = self.gradientLabelsContainer.bounds
        self.gradientLayer.cornerRadius = 10
        let colorSet = [
            UIColor.cellGradientStartColor,
            UIColor.cellGradientEndColor
        ]
        let location = [0.156, 0.9084]
        self.gradientLabelsContainer.addBackgroundGradient(with: gradientLayer, colorSet: colorSet, locations: location)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(gradientLabelsContainer)
        gradientLabelsContainer.addSubview(labelsStack)
        
        gradientLabelsContainer.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        gradientLabelsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        gradientLabelsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        gradientLabelsContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        labelsStack.topAnchor.constraint(equalTo: gradientLabelsContainer.topAnchor, constant: 18).isActive = true
        labelsStack.leadingAnchor.constraint(equalTo: gradientLabelsContainer.leadingAnchor, constant: 18).isActive = true
        labelsStack.trailingAnchor.constraint(equalTo: gradientLabelsContainer.trailingAnchor, constant: -18).isActive = true
        labelsStack.bottomAnchor.constraint(equalTo: gradientLabelsContainer.bottomAnchor, constant: -18).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




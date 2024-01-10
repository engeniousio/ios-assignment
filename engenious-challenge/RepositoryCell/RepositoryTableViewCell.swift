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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let additionalView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.heightAnchor.constraint(equalToConstant: 18).isActive = true
        return view
    }()
    private let decorationLayer = CAGradientLayer()
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.gradientLabelsContainer.layer)
        self.decorationLayer.frame = self.gradientLabelsContainer.bounds
        self.decorationLayer.cornerRadius = 10
        self.decorationLayer.isOpaque = false
        let colorSet = [
            UIColor.cellGradientStartColor,
            UIColor.cellGradientEndColor
        ]
        let location = [0.156, 0.9084]
        
        self.decorationLayer.applyDropShadow(withOffset: CGSize(width: 0, height: 6), opacity: 0.1, radius: 10, color: .cellShadowColor)
        self.gradientLabelsContainer.addBackgroundDecoration(with: decorationLayer, colorSet: colorSet, locations: location)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(gradientLabelsContainer)
        self.contentView.addSubview(additionalView)
        self.gradientLabelsContainer.addSubview(labelsStack)
        
        self.gradientLabelsContainer.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        self.gradientLabelsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        self.gradientLabelsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        self.gradientLabelsContainer.bottomAnchor.constraint(equalTo: additionalView.topAnchor).isActive = true
        
        self.additionalView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        self.additionalView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        self.additionalView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        self.labelsStack.topAnchor.constraint(equalTo: gradientLabelsContainer.topAnchor, constant: 18).isActive = true
        self.labelsStack.leadingAnchor.constraint(equalTo: gradientLabelsContainer.leadingAnchor, constant: 18).isActive = true
        self.labelsStack.trailingAnchor.constraint(equalTo: gradientLabelsContainer.trailingAnchor, constant: -18).isActive = true
        self.labelsStack.bottomAnchor.constraint(equalTo: gradientLabelsContainer.bottomAnchor, constant: -18).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




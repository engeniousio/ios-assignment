//
//  RepoTableViewCell.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    static let identifier = "RepositoryTableViewCell"
    
    // MARK: - Properties
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
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubviews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell configuration
    func configure(with viewModel: RepositoryCellViewModel) {
        self.titleLabel.text = viewModel.repository.name
        self.captionLabel.text = viewModel.repository.description
    }
    
    // MARK: - Subviews and Constraints
    private func setupSubviews() {
        contentView.addSubview(gradientLabelsContainer)
        contentView.addSubview(additionalView)
        self.gradientLabelsContainer.addSubview(labelsStack)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Gradient Labels Container
            self.gradientLabelsContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            self.gradientLabelsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            self.gradientLabelsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            self.gradientLabelsContainer.bottomAnchor.constraint(equalTo: additionalView.topAnchor),
            
            // Additional View
            self.additionalView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.additionalView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            self.additionalView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Labels Stack
            self.labelsStack.topAnchor.constraint(equalTo: gradientLabelsContainer.topAnchor, constant: 18),
            self.labelsStack.leadingAnchor.constraint(equalTo: gradientLabelsContainer.leadingAnchor, constant: 18),
            self.labelsStack.trailingAnchor.constraint(equalTo: gradientLabelsContainer.trailingAnchor, constant: -18),
            self.labelsStack.bottomAnchor.constraint(equalTo: gradientLabelsContainer.bottomAnchor, constant: -18)
        ])
    }
    
    // MARK: - Layout Sublayers
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: gradientLabelsContainer.layer)
        self.setupDecorationLayer()
    }
    
    // MARK: - Decoration Layer
    private func setupDecorationLayer() {
        self.decorationLayer.frame = gradientLabelsContainer.bounds
        self.decorationLayer.cornerRadius = 10
        self.decorationLayer.isOpaque = false
        
        let colorSet = [UIColor.cellGradientStartColor, UIColor.cellGradientEndColor]
        let location = [0.156, 0.9084]
        
        self.decorationLayer.applyDropShadow(withOffset: CGSize(width: 0, height: 6), opacity: 0.1, radius: 10, color: .cellShadowColor)
        self.gradientLabelsContainer.addBackgroundDecoration(with: decorationLayer, colorSet: colorSet, locations: location)
    }
}

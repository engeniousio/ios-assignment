//
//  RepoTableViewCell.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

final class RepoTableViewCell: UITableViewCell {
    
    enum Constants {
        static let cornerRadius: CGFloat = 10
        static let gradientFromColor: CGColor = AppColor.gradientFromColor.cgColor
        static let gradientToColor: CGColor = AppColor.gradientToColor.cgColor
        static let bgColor: UIColor = AppColor.bgColor
    }
    
    // MARK: - Subviews
    private lazy var gradientContainerView = UIView()
    private lazy var shadowView = UIView()
    private lazy var gradientLayer = CAGradientLayer()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = AppColor.headerTextColor
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = AppColor.subtitleTextColor
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = Constants.cornerRadius
        return stackView
    }()
    
    // MARK: - Lifecycle
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutAllSubviews()
        setupStyles()
        addLinearGradient()
        applyShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = contentView.frame
    }
    
    // MARK: - UI Configuration
    private func layoutAllSubviews() {
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(descriptionLabel)
        gradientContainerView.addSubview(
            containerStackView,
            withConstraints: .init(all: 16)
        )
        contentView.addSubview(
            shadowView,
            withConstraints: .init(top: 8, bottom: 8, leading: 20, trailing: 20)
        )
        contentView.addSubview(
            gradientContainerView,
            withConstraints: .init(top: 8, bottom: 8, leading: 20, trailing: 20)
        )
    }
    
    private func setupStyles() {
        selectionStyle = .none
        backgroundColor = .clear
        
        gradientContainerView.layer.cornerRadius = Constants.cornerRadius
        gradientContainerView.layer.masksToBounds = true
    }
    
    private func addLinearGradient() {
        gradientLayer.frame = contentView.bounds
        gradientLayer.colors = [
            Constants.gradientFromColor,
            Constants.gradientToColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientContainerView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func applyShadow() {
        shadowView.layer.cornerRadius = Constants.cornerRadius
        shadowView.backgroundColor = Constants.bgColor
        shadowView.layer.shadow(config: .repoCellDropShadow)
    }
}

// MARK: - Configuration
extension RepoTableViewCell {
    func configure(with vm: RepoCellViewModel) {
        titleLabel.text = vm.name
        descriptionLabel.text = vm.description
        descriptionLabel.isHidden = vm.description == nil
        gradientLayer.frame = contentView.frame
    }
}

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
        static let headerTextColor = AppColor.headerTextColor
        static let subtitleTextColor = AppColor.subtitleTextColor
        static let contentViewInsets = FrameConstraints(
            horizontal: 20,
            vertical: 8
        )
    }
    
    // MARK: - Subviews
    private lazy var gradientContainerView = UIView()
    private lazy var shadowView = UIView()
    private lazy var gradientLayer = CAGradientLayer()
    private lazy var titleLabel = UILabel()
    private lazy var descriptionLabel = UILabel()
    private lazy var containerStackView = UIStackView()
    
    // MARK: - Lifecycle
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutAllSubviews()
        setupStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        adjustGradientLayerFrame()
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
            withConstraints: Constants.contentViewInsets
        )
        contentView.addSubview(
            gradientContainerView,
            withConstraints: Constants.contentViewInsets
        )
    }
    
    private func setupStyles() {
        selectionStyle = .none
        backgroundColor = .clear
        
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.textColor = Constants.headerTextColor
        titleLabel.numberOfLines = .zero
        
        descriptionLabel.font = .systemFont(ofSize: 16, weight: .medium)
        descriptionLabel.textColor = Constants.subtitleTextColor
        descriptionLabel.numberOfLines = .zero
        
        containerStackView.axis = .vertical
        containerStackView.distribution = .fill
        containerStackView.spacing = Constants.cornerRadius
        
        gradientContainerView.layer.cornerRadius = Constants.cornerRadius
        gradientContainerView.layer.masksToBounds = true
        gradientLayer.colors = [
            Constants.gradientFromColor,
            Constants.gradientToColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientContainerView.layer.insertSublayer(gradientLayer, at: 0)
        
        shadowView.layer.cornerRadius = Constants.cornerRadius
        shadowView.backgroundColor = Constants.bgColor
        shadowView.layer.shadow(config: .repoCellDropShadow)
    }
    
    private func adjustGradientLayerFrame() {
        gradientLayer.frame = contentView.bounds
    }
}

// MARK: - Configuration
extension RepoTableViewCell {
    func configure(with vm: RepoCellViewModel) {
        titleLabel.text = vm.name
        descriptionLabel.text = vm.description
        descriptionLabel.isHidden = vm.description == nil
        adjustGradientLayerFrame()
    }
}

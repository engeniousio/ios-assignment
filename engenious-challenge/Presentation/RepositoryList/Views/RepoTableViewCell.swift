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
    }
    
    // MARK: - Subviews
    private lazy var gradientContainerView = UIView()
    private lazy var shadowContainerView = UIView()
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addLinearGradient()
        gradientContainerView.layer.cornerRadius = 10
        gradientContainerView.layer.masksToBounds = true
        shadowContainerView.layer.cornerRadius = 10
        shadowContainerView.layer.masksToBounds = false
        
        shadowContainerView.layer.cornerRadius = 10
        // TODO: Setup correct shadow
        shadowContainerView.layer.shadowColor = AppColor.headerTextColor.cgColor
        shadowContainerView.layer.shadowOpacity = 0.1
        shadowContainerView.layer.shadowOffset = CGSize(width: 0, height: 6)
        shadowContainerView.layer.shadowRadius = 10
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        print("+_+_+_")
    }
    
    
    private func layoutAllSubviews() {
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(descriptionLabel)
        gradientContainerView.addSubview(
            containerStackView,
            withConstraints: .init(all: 16)
        )
        shadowContainerView.addSubview(
            gradientContainerView,
            withConstraints: .zero
        )
        
        contentView.addSubview(
            shadowContainerView,
            withConstraints: .init(top: 8, bottom: 8, leading: 20, trailing: 20)
        )
    }
    
    private func setupStyles() {
        selectionStyle = .none
        contentView.backgroundColor = .clear
        contentView.layer.backgroundColor = UIColor.clear.cgColor
        gradientContainerView.layer.backgroundColor = UIColor.clear.cgColor
        gradientContainerView.backgroundColor = .clear
        shadowContainerView.backgroundColor = .clear
    }
    
    private func addLinearGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = contentView.bounds
        gradientLayer.colors = [
            AppColor.gradientFromColor.cgColor,
            AppColor.gradientToColor.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        gradientContainerView.layer.insertSublayer(gradientLayer, at: 0)
        
        gradientLayer.frame = contentView.bounds
    }
}

// MARK: - Configuration
extension RepoTableViewCell {
    func configure(with vm: RepoCellViewModel) {
        titleLabel.text = vm.name
        descriptionLabel.text = vm.description
        descriptionLabel.isHidden = vm.description == nil
    }
}

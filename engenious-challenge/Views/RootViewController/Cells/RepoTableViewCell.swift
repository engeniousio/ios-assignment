//
//  RepoTableViewCell.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import Combine
import UIKit

final class RepoTableViewCell: UITableViewCell {
    private var cancellablesBag = Set<AnyCancellable>()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.nameLabelFontSize, weight: .bold)
        label.textColor = Constants.nameLabelTextColor
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.descriptionLabelFontSize)
        label.textColor = Constants.descriptionLabelTextColor
        label.numberOfLines = Constants.descriptionLabelNumberOfLines
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = Constants.stackViewLayoutMargins
        stackView.layer.cornerRadius = Constants.stackViewCornerRadius
        stackView.clipsToBounds = true
        return stackView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.applyGradient()
            self.addShadow()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cancellablesBag.removeAll()
    }
}

extension RepoTableViewCell {
    func configure(with viewModel: RepoTableViewCellViewModel) {
        set(viewModel: viewModel)
    }
    
    private func set(viewModel: RepoTableViewCellViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        descriptionLabel.isHidden = viewModel.description == nil
    }
}

extension RepoTableViewCell {
    private func setupViews() {
        containerView.addSubview(stackView)
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.containerViewTopAnchorConstant),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.containerViewLeadingAnchorConstant),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.containerViewTrailingAnchorConstant),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.containerViewBottomAnchorConstant),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    private func applyGradient() {
        stackView.applyGradient(colors: Constants.gradientColors)
    }
    
    private func addShadow() {
        containerView.layer.shadowColor = Constants.containerViewShadowColor
        containerView.layer.shadowOffset = Constants.containerViewShadowOffset
        containerView.layer.shadowRadius = Constants.containerViewShadowRadius
        containerView.layer.shadowOpacity = Constants.containerViewShadowOpacity
        containerView.layer.masksToBounds = false
        containerView.layer.shouldRasterize = true
        containerView.layer.rasterizationScale = Constants.containerViewRasterizationScale
    }
}

private enum Constants {
    static let nameLabelFontSize: CGFloat = 18
    static let nameLabelTextColor: UIColor = UIColor(red: 0/255.0, green: 106/255.0, blue: 183/255.0, alpha: 1)
    
    static let descriptionLabelFontSize: CGFloat = 14
    static let descriptionLabelTextColor: UIColor = UIColor(red: 0/255.0, green: 72/255.0, blue: 124/255.0, alpha: 1)
    static let descriptionLabelNumberOfLines: Int = 0
    
    static let stackViewSpacing: CGFloat = 8
    static let stackViewLayoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    static let stackViewCornerRadius: CGFloat = 10
    
    static let containerViewTopAnchorConstant: CGFloat = 8
    static let containerViewLeadingAnchorConstant: CGFloat = 20
    static let containerViewTrailingAnchorConstant: CGFloat = -20
    static let containerViewBottomAnchorConstant: CGFloat = -8
    
    static let gradientColors: [UIColor] = [
        UIColor(red: 214/255.0, green: 238/255.0, blue: 255/255.0, alpha: 0.6),
        UIColor(red: 183/255.0, green: 225/255.0, blue: 255/255.0, alpha: 0.46)
    ]
    
    static let containerViewShadowColor: CGColor = UIColor(red: 0/255.0, green: 106/255.0, blue: 183/255.0, alpha: 0.08).cgColor
    static let containerViewShadowOffset: CGSize = CGSize(width: 0, height: 6)
    static let containerViewShadowRadius: CGFloat = 2
    static let containerViewShadowOpacity: Float = 1
    static let containerViewRasterizationScale: CGFloat = UIScreen.main.scale
}

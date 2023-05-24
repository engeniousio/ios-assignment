//
//  RepoTableViewCell.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    private let titleLabel: UILabel = .init()
	private let descriptionLabel: UILabel = .init()
	
	private let containerView: UIView = .init()
	private let stackView: UIStackView = .init() 
	
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		setupContainerView()
		setupStackView()
		setupTitleLabelAppearance()
		setupDescriptionLabelAppearance()
    }

	required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	private func setupContainerView() {
		contentView.addSubview(containerView)
		
		let layer = CAGradientLayer()
		layer.accessibilityHint = "gradient"
		layer.colors = [
			UIColor(named: "backgroundColorTop")!.cgColor, 
			UIColor(named: "backgroundColorBottom")!.cgColor
		]
		layer.startPoint = .init(x: 0.5, y: 0)
		layer.endPoint = .init(x: 0.5, y: 1)
		
		containerView.layer.insertSublayer(layer, at: 0)
		containerView.translatesAutoresizingMaskIntoConstraints = false

		containerView.layer.cornerRadius = 10
		containerView.clipsToBounds = true
		
		containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
		containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.5).isActive = true
		containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.5).isActive = true
		containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
	}
	
	private func setupStackView() {
		containerView.addSubview(stackView)
		
		stackView.spacing = 8
		stackView.axis = .vertical
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16).isActive = true
		stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
		stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
		stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16).isActive = true
	}

	private func setupTitleLabelAppearance() {
		stackView.addArrangedSubview(titleLabel)
		titleLabel.textColor = UIColor(named: "titleColor")
		titleLabel.font = .boldSystemFont(ofSize: 18)
	}
	
	private func setupDescriptionLabelAppearance() {
		stackView.addArrangedSubview(descriptionLabel)
		descriptionLabel.numberOfLines = 0
		descriptionLabel.textColor = UIColor(named: "descriptionColor")
		descriptionLabel.font = .boldSystemFont(ofSize: 14)
	}
	
	override func draw(_ rect: CGRect) {
		guard let sublayers = containerView.layer.sublayers, let gradientLayer = sublayers.first(where: { layer in
			layer.accessibilityHint == "gradient"
		}) else {
			return
		}
		
		gradientLayer.frame = containerView.layer.bounds
	}
	
	func update(with repo: Repo) {
		self.titleLabel.text = repo.name
		self.descriptionLabel.text = repo.description
	}
	
}

//
//  RepoTableViewCell.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 106 / 255, blue: 183 / 255, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 72 / 255, blue: 124 / 255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor(red: 214/255.0, green: 238/255.0, blue: 255/255.0, alpha: 0.6).cgColor,
            UIColor(red: 183/255.0, green: 225/255.0, blue: 255/255.0, alpha: 0.456).cgColor
        ]
        layer.locations = [0.156, 0.9084] as [NSNumber]
        let angle = 93.54 // Gradient angle in degrees
        layer.startPoint = calculateStartPoint(forAngle: angle)
        layer.endPoint = calculateEndPoint(forAngle: angle)

        return layer
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContainerView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupContainerView() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.layer.insertSublayer(gradientLayer, at: 0)
        containerView.layer.shadowColor = UIColor(red: 0/255, green: 106/255, blue: 183/255, alpha: 1.0).cgColor
        containerView.layer.shadowOpacity = 0.08
        containerView.layer.shadowOffset = CGSize(width: 0, height: 6)
        containerView.layer.shadowRadius = 12
        containerView.layer.shadowPath = UIBezierPath(rect: containerView.bounds).cgPath

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.shadowPath = UIBezierPath(rect: containerView.bounds).cgPath
        updateGradientLayer()
    }

    private func updateGradientLayer() {
        gradientLayer.frame = containerView.bounds
    }

    private func calculateStartPoint(forAngle angle: Double) -> CGPoint {
        let angleRad = angle / 180.0 * .pi
        return CGPoint(x: 0.5 - sin(angleRad) * 0.5, y: 0.5 + cos(angleRad) * 0.5)
    }

    private func calculateEndPoint(forAngle angle: Double) -> CGPoint {
        let angleRad = angle / 180.0 * .pi
        return CGPoint(x: 0.5 + sin(angleRad) * 0.5, y: 0.5 - cos(angleRad) * 0.5)
    }

}

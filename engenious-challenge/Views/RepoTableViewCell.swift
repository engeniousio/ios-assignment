//
//  RepoTableViewCell.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

final class RepoTableViewCell: UITableViewCell {

    let backgroundContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 223, green: 238, blue: 252, alpha: 1.0)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(red: 45, green: 105, blue: 177, alpha: 1.0)
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor(red: 28, green: 71, blue: 120, alpha: 1.0)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(backgroundContainerView)
        backgroundContainerView.addSubview(titleLabel)
        backgroundContainerView.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            backgroundContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backgroundContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            backgroundContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            backgroundContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            titleLabel.topAnchor.constraint(equalTo: backgroundContainerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundContainerView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundContainerView.trailingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 26),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            descriptionLabel.leadingAnchor.constraint(equalTo: backgroundContainerView.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: backgroundContainerView.trailingAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(equalTo: backgroundContainerView.bottomAnchor, constant: -16)
        ])

        // Remove horizontal divider
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        self.layoutMargins = UIEdgeInsets.zero
    }
}


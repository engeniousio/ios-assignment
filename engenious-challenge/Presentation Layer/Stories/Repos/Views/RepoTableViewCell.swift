//
//  RepoTableViewCell.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    
    // MARK: - Constants

    private enum Constants {
        static let titleFontSize: CGFloat = 18
        static let descriptionFontSize: CGFloat = 14
    }

    // MARK: - Properties(public)

    let titleLabel: UILabel = .init()
    let descriptionLabel: UILabel = .init()
    let view: UIView = .init()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(view)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods(private)

    private func setupView() {
        titleLabel.textColor = UIColor.titleColor
        titleLabel.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize, weight: .bold)
        
        descriptionLabel.textColor = UIColor.textColor
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize, weight: .medium)
        descriptionLabel.numberOfLines = 2
        
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor.titleColor?.withAlphaComponent(0.1)
        view.layer.shadowColor = UIColor.titleColor?.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 5
    }
    
    private func setupConstraints() {
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 26).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
    }
}

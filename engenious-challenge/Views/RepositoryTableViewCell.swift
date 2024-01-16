//
//  RepoTableViewCell.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

protocol RepositoryTableViewStyling {
    var backgroundColor: UIColor { get }
    var titleLabelColor: UIColor { get }
    var titleLabelFont: UIFont { get }
    var subtitleLabelColor: UIColor { get }
}

final class RepositoryTableViewCell: UITableViewCell, ControlSetup {
    private enum Consts {
        static let insets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        static let numberOfLines = 0
        static let cornerRadius: CGFloat = 10
    }
    
    private let style: RepositoryTableViewStyling
    private lazy var titleLabel = UILabel()
    private lazy var containerView = UIView()
    private lazy var subtitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.style = RepositoryTableViewStyle()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        controlSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(cellViewModel: RepositoryModel) {
        titleLabel.text = cellViewModel.name
        subtitleLabel.text = cellViewModel.description
    }
    
    func setupAutoLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Consts.insets.top),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Consts.insets.left),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Consts.insets.right),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Consts.insets.bottom),
            
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Consts.insets.top),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Consts.insets.left),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Consts.insets.right),
          
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Consts.insets.top),
            subtitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Consts.insets.left),
            subtitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Consts.insets.right),
            subtitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Consts.insets.bottom)
        ])
    }
    
    func setupSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
    }
    
    func setupStyle() {
        containerView.backgroundColor = style.backgroundColor
        titleLabel.textColor = style.titleLabelColor
        titleLabel.font = style.titleLabelFont
        subtitleLabel.textColor = style.subtitleLabelColor
        subtitleLabel.numberOfLines = Consts.numberOfLines
        
        containerView.layer.cornerRadius = Consts.cornerRadius
    }
}

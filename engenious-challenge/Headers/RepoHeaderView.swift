//
//  RepoHeaderView.swift
//  engenious-challenge
//
//  Created by Pavlo on 22.02.2024.
//

import UIKit

final class RepoHeaderView: UIView {
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "Repositories"
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = #colorLiteral(red: 0, green: 0.4990749955, blue: 0.768505156, alpha: 1)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14.0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14.0),
            titleLabel.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor)
        ])
    }
}

//
//  RepoHeaderView.swift
//  engenious-challenge
//
//  Created by Volodymyr Mykhailiuk on 10.02.2024.
//

import UIKit

final class RepoHeaderView: UIView {
    
    // MARK: - Subviews
    private lazy var labelView = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutAllSubviews()
        setupStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutAllSubviews() {
        addSubview(
            labelView,
            withConstraints: .init(top: 8, bottom: 8, leading: 20, trailing: 20)
        )
    }
    
    private func setupStyles() {
        backgroundColor = .white
        labelView.textColor = AppColor.headerTextColor
        labelView.font = .systemFont(ofSize: 24, weight: .semibold)
    }
}

// MARK: - Setup
extension RepoHeaderView {
    func setup(with name: String) {
        labelView.text = "Repositories"
    }
}


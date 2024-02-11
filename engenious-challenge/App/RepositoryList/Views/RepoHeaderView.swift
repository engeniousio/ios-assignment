//
//  RepoHeaderView.swift
//  engenious-challenge
//
//  Created by Volodymyr Mykhailiuk on 10.02.2024.
//

import UIKit

final class RepoHeaderView: UIView {
    enum Constants {
        static let bgColor = AppColor.bgColor
        static let textColor = AppColor.headerTextColor
        static let viewInsets = FrameConstraints(
            horizontal: 20,
            vertical: 8
        )
    }
    
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
    
    // MARK: - UI Configuration
    private func layoutAllSubviews() {
        addSubview(
            labelView,
            withConstraints: Constants.viewInsets
        )
    }
    
    private func setupStyles() {
        backgroundColor = Constants.bgColor
        labelView.textColor = Constants.textColor
        labelView.font = .systemFont(ofSize: 24, weight: .semibold)
    }
}

// MARK: - Setup
extension RepoHeaderView {
    func setup(with name: String) {
        labelView.text = name
    }
}

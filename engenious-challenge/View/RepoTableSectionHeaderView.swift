//
//  RepoTableSectionHeaderView.swift
//  engenious-challenge
//
//  Created by nikita on 24.05.2023.
//

import UIKit

class RepoTableSectionHeaderView: UITableViewHeaderFooterView {
	
	private var titleLabel: UILabel = .init()
	
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		
		setupTitleView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupTitleView() {
		contentView.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		
		titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
		titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
		titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
		titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
		
		titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
		titleLabel.textColor = UIColor(named: "titleColor")
	}
	
	func update(with title: String) {
		titleLabel.text = title
	}
	
}

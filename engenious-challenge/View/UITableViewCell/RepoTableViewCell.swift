//
//  RepoTableViewCell.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    let titleLabel: UILabel = .init()
    let descriptioLabel: UILabel = .init()
    private let stackView: UIStackView = .init()
    
    func setCell(_ data:Repository) {
        titleLabel.text = data.name
        descriptioLabel.text = data.description
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: loadUI
fileprivate extension RepoTableViewCell {
    func loadUI() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptioLabel)
        contentView.addSubview(stackView)
        setConstraints()
        
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        titleLabel.font = AppStyles.Fonts.title
        titleLabel.textColor = self.tintColor
        descriptioLabel.font = AppStyles.Fonts.description
        descriptioLabel.textColor = .black
        titleLabel.numberOfLines = 0
        descriptioLabel.numberOfLines = 0
    }
    
    func setConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AppStyles.containerMargins1).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppStyles.containerMargins1).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppStyles.containerMargins1).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -AppStyles.containerMargins1).isActive = true
    }
}


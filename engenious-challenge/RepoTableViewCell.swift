//
//  RepoTableViewCell.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    let titleLabel: UILabel = .init()
    let subtitleLabel: UILabel = UILabel()
    let background: UIView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        
        background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        background.trailingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        
        background.addSubview(titleLabel)
        
        background.backgroundColor = Colors.blueWithAlpha
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
//        titleLabel.bottomAnchor.constraint(equalTo: contentView.ce, constant: -16).isActive = true
        
        titleLabel.font = titleLabel.font.withSize(18)
        titleLabel.textColor = Colors.blue
        
        background.addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        subtitleLabel.font = subtitleLabel.font.withSize(14)
        subtitleLabel.textColor = Colors.darkBlue
        subtitleLabel.numberOfLines = 0
        subtitleLabel.lineBreakMode = .byWordWrapping
        setGradientBackground()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        contentView.layer.cornerRadius = 10
    }
    
    func setGradientBackground() {
        let colorTop = Colors.gradient1.cgColor
        let colorBottom = Colors.gradient2.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.frame
                
        self.layer.insertSublayer(gradientLayer, at:0)
    }

}

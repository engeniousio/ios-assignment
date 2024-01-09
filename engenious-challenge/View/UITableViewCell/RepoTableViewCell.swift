//
//  RepoTableViewCell.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

class RepoTableViewCell: ClearCell {

    let titleLabel: UILabel = .init()
    let descriptioLabel: UILabel = .init()
    private let stackView: UIStackView = .init()
    let backgroundOverlayView:UIView = .init()
    
    func setCell(_ data:Repository) {
        titleLabel.text = data.name
        descriptioLabel.text = data.description
        DispatchQueue.main.async {
            self.updateGradientFrame()
        }
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
        let gradientView = UIView()
        gradientView.layer.name = "gradientView"
        backgroundOverlayView.addSubview(gradientView)

        contentView.addSubview(backgroundOverlayView)
        gradientView.addConstaits([.left:0, .right:0, .top:0, .bottom:0], toView: backgroundOverlayView)
        gradientView.layer.masksToBounds = true
        gradientView.layer.cornerRadius = AppStyles.viewCornerRadius
        backgroundOverlayView.addSubview(stackView)
        
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        titleLabel.font = AppStyles.Fonts.title
        titleLabel.textColor = self.tintColor
        descriptioLabel.font = AppStyles.Fonts.description
        descriptioLabel.textColor = K.Colors.blue1
        titleLabel.numberOfLines = 0
        descriptioLabel.numberOfLines = 0

        backgroundOverlayView.layer.cornerRadius = AppStyles.viewCornerRadius
        let _ = gradientView.layer.gradient(colors: [K.Colors.blueOpacity1, K.Colors.blueOpacity2].compactMap({$0.cgColor}), frame: .init(origin: .zero, size: contentView.frame.size))
        
        let shadowView = UIView()
        shadowView.layer.name = "shadowView"
        shadowView.layer.cornerRadius = backgroundOverlayView.layer.cornerRadius
        backgroundOverlayView.insertSubview(shadowView, at:0)
        shadowView.addConstaits([.left:0, .right:0, .top:0, .bottom:0], toView: backgroundOverlayView)
        shadowView.backgroundColor = .white
        shadowView.layer.shadowColor = K.Colors.blue.cgColor
        shadowView.layer.shadowOpacity = 0.1
        setConstraints()
    }
    
    
    func setConstraints() {
        backgroundOverlayView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let views = [stackView, backgroundOverlayView]
        views.forEach {
            let topConstant = AppStyles.containerMargins1 / ($0 == self.backgroundOverlayView ? 2 : 1)
            $0.topAnchor.constraint(equalTo: $0.superview!.topAnchor, constant: topConstant).isActive = true
            $0.leadingAnchor.constraint(equalTo: $0.superview!.leadingAnchor, constant: AppStyles.containerMargins1).isActive = true
            $0.trailingAnchor.constraint(equalTo: $0.superview!.trailingAnchor, constant: -AppStyles.containerMargins1).isActive = true
            $0.bottomAnchor.constraint(equalTo: $0.superview!.bottomAnchor, constant: -topConstant).isActive = true
        }
        
    }
    
    func updateGradientFrame() {
        let view = backgroundOverlayView.subviews.first(where: {$0.layer.name == "gradientView"})!
        let secondView = view.layer.sublayers!.first(where: {$0.name == "CAGradientLayer"})!
        secondView.frame = .init(origin: .zero, size: contentView.frame.size)
    }
}


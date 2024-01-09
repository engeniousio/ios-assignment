//
//  RepoTableViewCell.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

class RepoTableViewCell: ClearCell {

    private let titleLabel: UILabel = .init()
    private let descriptioLabel: UILabel = .init()
    private let stackView: UIStackView = .init()
    private let backgroundOverlayView:UIView = .init()
    
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
        backgroundOverlayView.addSubview(stackView)
        addBackground()
        setupUI()
        setConstraints()
    }
    
    func setupUI() {
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        titleLabel.font = AppStyles.Fonts.title
        titleLabel.textColor = self.tintColor
        descriptioLabel.font = AppStyles.Fonts.description
        descriptioLabel.textColor = K.Colors.blue1
        titleLabel.numberOfLines = 0
        descriptioLabel.numberOfLines = 0
    }
    
    func addBackground() {
        let gradientView = UIView()
        gradientView.layer.name = "gradientView"
        backgroundOverlayView.insertSubview(gradientView, at: 0)

        backgroundOverlayView.layer.cornerRadius = AppStyles.viewCornerRadius
        contentView.addSubview(backgroundOverlayView)
        
        gradientView.addConstaits([.left:0, .right:0, .top:0, .bottom:0])
        gradientView.layer.masksToBounds = true
        gradientView.layer.cornerRadius = AppStyles.viewCornerRadius
        
        let _ = gradientView.layer.gradient(colors: [K.Colors.blueOpacity1, K.Colors.blueOpacity2].compactMap({$0.cgColor}), frame: .init(origin: .zero, size: contentView.frame.size), insertAt: 0)
        
        let shadowView = UIView()
        shadowView.layer.name = "shadowView"
        shadowView.layer.cornerRadius = backgroundOverlayView.layer.cornerRadius
        backgroundOverlayView.insertSubview(shadowView, at:0)
        shadowView.addConstaits([.left:0, .right:0, .top:0, .bottom:0])
        shadowView.backgroundColor = .white
        shadowView.layer.shadow(color: K.Colors.blue.cgColor)
    }
    
    func setConstraints() {
        let views = [stackView, backgroundOverlayView]
        views.forEach {
            let topConstant = AppStyles.containerMargins1 / ($0 == self.backgroundOverlayView ? 2 : 1)
            $0.addConstaits([.top:topConstant, .bottom:-topConstant, .left:AppStyles.containerMargins1, .right:-AppStyles.containerMargins1])
        }
    }
    
    func updateGradientFrame() {
        let view = backgroundOverlayView.subviews.first(where: {$0.layer.name == "gradientView"})!
        let secondView = view.layer.sublayers!.first(where: {$0.name == "CAGradientLayer"})!
        secondView.frame = .init(origin: .zero, size: contentView.frame.size)
    }
}


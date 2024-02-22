//
//  ShadowedStackView.swift
//  engenious-challenge
//
//  Created by Pavlo on 22.02.2024.
//

import UIKit

final class GradientStackView: UIStackView {

    var backgroundColors: [UIColor] = [#colorLiteral(red: 0.7176470588, green: 0.8823529412, blue: 1, alpha: 0.6), #colorLiteral(red: 0.8392156863, green: 0.9333333333, blue: 1, alpha: 0.45)] {
        didSet {
            applyGradientColors()
        }
    }
    
    var shadowColor: UIColor = #colorLiteral(red: 0.8392156863, green: 0.9333333333, blue: 1, alpha: 1) {
        didSet {
            applyShadow()
        }
    }
    
    var shadowOffset: CGSize = .init(width: 0.0, height: 0.0) {
        didSet {
            applyShadow()
        }
    }
    
    var shadowRadius: CGFloat = 0.0 {
        didSet {
            applyShadow()
        }
    }
    
    override class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradientColors()
        applyShadow()
    }
    
    private func applyGradientColors() {
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.colors = backgroundColors.map{ $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    }
    
    private func applyShadow() {
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.masksToBounds = false
        gradientLayer.shadowOpacity = 1.0
        gradientLayer.shadowRadius = shadowRadius
        gradientLayer.shadowOffset = shadowOffset
        gradientLayer.shadowColor = shadowColor.cgColor
        gradientLayer.shouldRasterize = true
        gradientLayer.rasterizationScale = UIScreen.main.scale
    }
}

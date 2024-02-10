//
//  UIView+Ext.swift
//  engenious-challenge
//
//  Created by Eugene Garkavenko on 10.02.2024.
//

import UIKit

extension UIView {
    func applyGradient(colors: [UIColor], locations: [NSNumber] = [0.0, 1.0]) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        
        self.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        
        self.layer.insertSublayer(gradient, at: 0)
    }
}

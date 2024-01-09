//
//  UIView.swift
//  engenious-challenge
//
//  Created by Misha Dovhiy on 09.01.2024.
//

import UIKit

extension UIView {
    func addConstaits(_ constants:[NSLayoutConstraint.Attribute:CGFloat], toView:UIView) {
        constants.forEach { (key, value) in
            let keyNil = key == .height || key == .width
            let item:Any? = keyNil ? nil : toView
            toView.addConstraint(.init(item: self, attribute: key, relatedBy: .equal, toItem: item, attribute: key, multiplier: 1, constant: value))
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func addBluer(frame:CGRect? = nil, style:UIBlurEffect.Style = (.init(rawValue: -10) ?? .regular), insertAt:Int? = nil) -> UIVisualEffectView {
        
        let blurEffect = UIBlurEffect(style: style)
        let bluer = UIVisualEffectView(effect: blurEffect)
        let constaints:[NSLayoutConstraint.Attribute : CGFloat] = [.leading:0, .top:0, .trailing:0, .bottom:0]

        for _ in 0..<5 {
            let vibracity = UIVisualEffectView(effect: UIBlurEffect(style: style))
            bluer.contentView.addSubview(vibracity)
            vibracity.addConstaits(constaints, toView: bluer)
        }
        
        bluer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if let at = insertAt {
            self.insertSubview(bluer, at: at)
        } else {
            self.addSubview(bluer)
        }
        
        bluer.addConstaits(constaints, toView: self)

        return bluer
    }
}




extension CALayer {
    func gradient(colors:[CGColor], points:(start:CGPoint, end:CGPoint)? = nil, locations:[NSNumber]? = nil, frame:CGRect? = nil, type:CAGradientLayerType? = nil, insertAt:UInt32? = nil, zpozition:Int? = nil) -> CAGradientLayer? {
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "CAGradientLayer"
        gradientLayer.colors = colors
        if let type = type {
            gradientLayer.type = type
        }

        if let locations = locations {
            gradientLayer.locations = locations
        } else {
            gradientLayer.locations = [0.0, 0.75, 1.0]
        }
        
        let resultFrame = frame ?? .init(origin: .zero, size: frame?.size ?? self.frame.size)
        gradientLayer.startPoint = points?.start ?? .init(x: 0.5, y: 0)
        gradientLayer.endPoint = points?.end ?? .init(x: 0.5, y: 1)
        gradientLayer.frame = resultFrame
        if let at = insertAt {
            self.insertSublayer(gradientLayer, at: at)
        } else {
            self.addSublayer(gradientLayer)
        }
        if let zpozition = zpozition {
            gradientLayer.zPosition = CGFloat.init(integerLiteral: zpozition)
        }
        return gradientLayer
    }
}

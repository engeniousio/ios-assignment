//
//  UIView.swift
//  engenious-challenge
//
//  Created by Misha Dovhiy on 09.01.2024.
//

import UIKit

extension UIView {
    func addConstaits(_ constants:[NSLayoutConstraint.Attribute:CGFloat]) {
        constants.forEach { (key, value) in
            let keyNil = key == .height || key == .width
            if let toView = self.superview {
                let item:Any? = keyNil ? nil : toView
                toView.addConstraint(.init(item: self, attribute: key, relatedBy: .equal, toItem: item, attribute: key, multiplier: 1, constant: value))
            }
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
            vibracity.addConstaits(constaints)
        }
        bluer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if let at = insertAt {
            self.insertSubview(bluer, at: at)
        } else {
            self.addSubview(bluer)
        }
        bluer.addConstaits(constaints)
        return bluer
    }
}


//
//  CALayer.swift
//  engenious-challenge
//
//  Created by Misha Dovhiy on 09.01.2024.
//

import QuartzCore

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
    
    func shadow(color:CGColor, opacity:Float = 0.1, offset:CGSize = .init(width: 0, height: 5)) {
        shadowColor = color
        shadowOpacity = opacity
        shadowOffset = offset
    }
}

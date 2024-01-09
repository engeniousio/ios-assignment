//
//  UIFont.swift
//  engenious-challenge
//
//  Created by Misha Dovhiy on 09.01.2024.
//

import UIKit

extension UIFont {
    
    static func customFont(size:CGFloat, weight:Weight) -> UIFont {
        if let font = UIFont.init(name: "SF-Pro-" + weight.sfFontName, size: size) {
            return UIFontMetrics.default.scaledFont(for: font)
        } else {
            return .systemFont(ofSize: size, weight: weight)
        }
    }
}

extension UIFont.Weight {
    var sfFontName:String {
        switch self {
        default:
            return "Regular"
        }
    }
}

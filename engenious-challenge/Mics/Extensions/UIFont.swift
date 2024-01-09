//
//  UIFont.swift
//  engenious-challenge
//
//  Created by Misha Dovhiy on 09.01.2024.
//

import UIKit

extension UIFont {
    static func customFont(size:CGFloat, weight:Weight) -> UIFont {
      //  let font:UIFont = .init(name: "SF-Pro-Text-" + weight.sfFontName, size: size)!
        //return UIFontMetrics.default.scaledFont(for: font)
        return .systemFont(ofSize: size, weight: weight)
    }
}

extension UIFont.Weight {
    var sfFontName:String {
        switch self {
///        case .bold:return "Bold"
        default:
            return "Regulare.otf"
        }
    }
}

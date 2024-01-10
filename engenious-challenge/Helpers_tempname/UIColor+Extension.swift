//
//  UIColor+Extension.swift
//  engenious-challenge
//
//  Created by Юлія Воротченко on 10.01.2024.
//

import UIKit

extension UIColor {
    static var navigationTitleColor: UIColor {
        return appColor(.navigationTitleColor)
    }

    static var listTitleColor: UIColor {
        return appColor(.listTitleColor)
    }

    static var cellTextColor: UIColor {
        return appColor(.cellTextColor)
    }

    static var cellShadowColor: UIColor {
        return appColor(.cellShadowColor)
    }

    static var cellGradientStartColor: UIColor {
        return appColor(.cellGradientStartColor)
    }

    static var cellGradientEndColor: UIColor {
        return appColor(.cellGradientEndColor)
    }

    static func appColor(_ colorName: AppColorName) -> UIColor {
        return UIColor(named: colorName.rawValue) ?? .black
    }
}

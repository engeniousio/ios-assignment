//
//  UIView+CornerRadius.swift
//  engenious-challenge
//
//  Created by Pavlo on 22.02.2024.
//

import UIKit

extension UIView {
    func setCornerRadius(_ radius: CGFloat, masksToBounds: Bool = true) {
        layer.cornerRadius = radius
        layer.masksToBounds = masksToBounds
    }
}

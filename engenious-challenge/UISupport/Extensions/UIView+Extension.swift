//
//  UIView+Extension.swift
//  engenious-challenge
//
//  Created by Юлія Воротченко on 10.01.2024.
//

import UIKit

extension UIView {
    func addBackgroundDecoration(with layer: CAGradientLayer, gradientFrame: CGRect? = nil, colorSet: [UIColor],
                     locations: [Double], startEndPoints: (CGPoint, CGPoint)? = nil) {
        layer.frame = gradientFrame ?? self.bounds
        layer.frame.origin = .zero

        let layerColorSet = colorSet.map { $0.cgColor }
        let layerLocations = locations.map { $0 as NSNumber }

        layer.colors = layerColorSet
        layer.locations = layerLocations

        if let startEndPoints = startEndPoints {
            layer.startPoint = startEndPoints.0
            layer.endPoint = startEndPoints.1
        }

        self.layer.insertSublayer(layer, at: 0)
    }
}

import UIKit

// MARK: - Methods
public extension UIView {
    
    /// SwifterSwift: Add array of subviews to view.
    ///
    /// - Parameter subviews: array of subviews to add to self.
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach({ self.addSubview($0) })
    }

    /// SwifterSwift: Remove  subview in view with tag.
    func removeSubviewWithTag(_ tag: Int) {
        subviews.forEach({
            if let viewWithTag = $0.viewWithTag(tag) {
                viewWithTag.removeFromSuperview()
            }
        })
    }
    
    /// A helper function to add multiple subviews.
    func addSubviews(_ subviews: UIView...) {
      subviews.forEach {
        addSubview($0)
      }
    }
}

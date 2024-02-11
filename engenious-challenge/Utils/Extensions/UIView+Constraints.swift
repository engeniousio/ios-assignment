//
//  UIView+Constraints.swift
//  engenious-challenge
//
//  Created by Volodymyr Mykhailiuk on 09.02.2024.
//

import UIKit

extension UIView {
    /// Defines frame constraints' values
    ///
    /// Pass '**nil**' to the related constraint to omit it
    struct FrameConstraints {
        var top: CGFloat?
        var bottom: CGFloat?
        var leading: CGFloat?
        var trailing: CGFloat?
        
        static var zero: FrameConstraints {
            FrameConstraints(
                top: 0,
                bottom: 0,
                leading: 0,
                trailing: 0
            )
        }

        init(
            top: CGFloat? = 0,
            bottom: CGFloat? = 0,
            leading: CGFloat? = 0,
            trailing: CGFloat? = 0
        ) {
            self.top = top
            self.bottom = bottom
            self.leading = leading
            self.trailing = trailing
        }
        
        init(horizontal: CGFloat?, vertical: CGFloat?) {
            self.top = vertical
            self.bottom = vertical
            self.leading = horizontal
            self.trailing = horizontal
        }
        
        init(all: CGFloat) {
            self.top = all
            self.bottom = all
            self.leading = all
            self.trailing = all
        }
    }

    enum ViewPosition {
        case center(width: CGFloat? = nil, height: CGFloat? = nil)
        case constraints(_ frameConstraints: FrameConstraints)
    }
    
    func addFrameConstraintsTo(view: UIView, constraints: FrameConstraints) {
        view.translatesAutoresizingMaskIntoConstraints = false
        if let leadingValue = constraints.leading {
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingValue).isActive = true
        }
        if let topValue = constraints.top {
            view.topAnchor.constraint(equalTo: topAnchor, constant: topValue).isActive = true
        }
        if let trailingValue = constraints.trailing {
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailingValue).isActive = true
        }
        if let bottomValue = constraints.bottom {
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomValue).isActive = true
        }
    }
    
    func addFullSizeSubview(_ subview: UIView) {
        addSubview(subview, withConstraints: FrameConstraints.zero)
    }
    
    func addSubview(_ subview: UIView, withConstraints constraints: FrameConstraints) {
        addSubview(subview)
        addFrameConstraintsTo(view: subview, constraints: constraints)
    }

    func addSubview(_ subview: UIView, withPosition position: ViewPosition) {
        addSubview(subview)
        switch position {
        case .constraints(let constraints):
            addFrameConstraintsTo(view: subview, constraints: constraints)
        case .center(let width, let height):
            subview.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                subview.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                subview.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])

            if let width = width, let height = height {
                NSLayoutConstraint.activate([
                    subview.widthAnchor.constraint(equalToConstant: width),
                    subview.heightAnchor.constraint(equalToConstant: height)
                ])
            }
        }
    }
}

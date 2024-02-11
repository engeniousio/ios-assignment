//
//  UINavigationBar+Attributes.swift
//  engenious-challenge
//
//  Created by Volodymyr Mykhailiuk on 11.02.2024.
//

import UIKit

extension UINavigationBar {
    func applyAttributes(_ attributes: [NSAttributedString.Key : Any]?) {
        titleTextAttributes = attributes
        
        if #available(iOS 11.0, *) {
            largeTitleTextAttributes = attributes
        }
    }
}

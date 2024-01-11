//
//  UIViewController+Extension.swift
//  engenious-challenge
//
//  Created by Юлія Воротченко on 11.01.2024.
//

import Foundation
import UIKit

extension UIViewController {
    
    func startLoading() {
        self.view.hideToastActivity()
        self.view.makeToastActivity(.center)
    }
    
    func stopLoading() {
        //remove the spinner view controller
        self.view.removeSubviewWithTag(403415)
        self.view.hideToastActivity()
    }
}

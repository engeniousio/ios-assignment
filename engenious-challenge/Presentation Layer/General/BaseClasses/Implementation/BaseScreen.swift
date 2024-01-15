//
//  BaseScreen.swift
//  engenious-challenge
//
//  Created by admin on 14.01.2024.
//

import Foundation
import UIKit

class BaseScreen: UIViewController, BaseScreenProtocol {
    
    // MARK: - Properties(private)

    private var pendingViewLoadUpdates: [() -> Void] = []
    
    // MARK: - Methods

    @discardableResult
    func afterViewLoaded(perform action: @escaping () -> Void) -> Bool {
        if isViewLoaded {
            action()
            return true
        }
        else {
            pendingViewLoadUpdates.append(action)
            return false
        }
    }
    
    
}

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
        self.view.removeSubviewWithTag(403415)
        self.view.hideToastActivity()
    }
    
    func displayAlertMessage(message: String?) {
        guard let message = message,
              !message.isEmpty
        else { return }
        let model = NotificationBuilder()
        model.setTitle("")
            .setBody(message)
            .bulid()
    }
}

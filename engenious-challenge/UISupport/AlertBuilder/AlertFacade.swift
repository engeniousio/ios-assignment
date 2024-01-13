//
//  File.swift
//  engenious-challenge
//
//  Created by Юлія Воротченко on 13.01.2024.
//

import UIKit

protocol AlertFacade {
    func notify()
}

extension AlertFacade where Self: NotificationBuilder {
    
    func notify() {
        let alert = UIAlertController(title: self.title,
                                      message: self.body,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: {(_: UIAlertAction!) in
            self.agreeHandler?()
        }))
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.filter({$0.isKeyWindow}).first
        
        guard let topController: UIViewController = window?.rootViewController else {
            return
        }
        topController.present(alert, animated: true, completion: nil)
    }
}

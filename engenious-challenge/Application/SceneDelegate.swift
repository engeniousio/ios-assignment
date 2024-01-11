//
//  SceneDelegate.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navigationBarAppearanceManager = NavigationBarAppearanceManager()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let nc = UINavigationController(rootViewController: DashboardViewController())
        self.navigationBarAppearanceManager.setAppearance(for: nc)
        window.rootViewController = nc
        self.window = window
        window.makeKeyAndVisible()
    }
}
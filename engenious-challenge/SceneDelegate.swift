//
//  SceneDelegate.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let viewModel = ViewModel()
        let view = RootViewController()
        viewModel.view = view
        view.viewModel = viewModel
        let nc = UINavigationController(rootViewController: view)
        window.rootViewController = nc
        self.window = window
        window.makeKeyAndVisible()
    }

}


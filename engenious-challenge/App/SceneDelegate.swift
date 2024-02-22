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
        self.window = UIWindow(windowScene: windowScene)
        
        let repoViewController = RepoViewController()
        let navigationController = UINavigationController(rootViewController: repoViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: #colorLiteral(red: 0.0003798490798, green: 0.2827036381, blue: 0.4286119938, alpha: 1),
            .font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}


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
        
        let window = createWindow(windowScene: windowScene)
        let initialViewController = buildInitialViewController()
        configureWindow(window, with: initialViewController)
        
        self.window = window
    }

    private func createWindow(windowScene: UIWindowScene) -> UIWindow {
        return UIWindow(windowScene: windowScene)
    }

    private func buildInitialViewController() -> UIViewController {
        let viewContainer = RepositoryContainer()
        return viewContainer.buildRepository()
    }

    private func configureWindow(_ window: UIWindow, with viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}


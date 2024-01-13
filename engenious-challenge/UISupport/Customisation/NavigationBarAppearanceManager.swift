//
//  File.swift
//  engenious-challenge
//
//  Created by Юлія Воротченко on 11.01.2024.
//

import UIKit

struct NavigationBarAppearanceManager {
    
    func setAppearance(for navigationController: UINavigationController) {
        let appearance = createAppearance()
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.standardAppearance = appearance
    }
    
    private func createAppearance() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.clear]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.navigationTitleColor]
        return appearance
    }
}

//
//  File.swift
//  PhotographyApp
//
//  Created by Elsever on 12.04.25.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var window: UIWindow?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private func setupTabBarController() {
        let tabBarComtroller = TabBarController()
        window?.rootViewController = tabBarComtroller
        window?.makeKeyAndVisible()
    }
    
    func start() {
        setupTabBarController()
    }
}

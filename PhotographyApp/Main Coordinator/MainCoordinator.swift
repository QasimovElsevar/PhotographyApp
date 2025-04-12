//
//  File.swift
//  PhotographyApp
//
//  Created by Elsever on 12.04.25.
//

import UIKit

protocol MainNavigation {
    func start ()
   // func showFeedController()
    func showSearchController()
    func showUploadController()
    func showLoginCOntroller()
    func showProfileController()
}

final class MainCoordinator: MainNavigation {
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
    
    func showSearchController() {
        let controller = SearchController()
        navigationController.show(controller, sender: nil)
    }
    
    func showUploadController() {
        let controller = UploadController()
        navigationController.show(controller, sender: nil)
    }
    
    func showLoginCOntroller() {
        let controller = LoginController()
        navigationController.show(controller, sender: nil)
    }
    
    func showProfileController() {
        let controller = ProfileController()
        navigationController.show(controller, sender: nil)
    }
}

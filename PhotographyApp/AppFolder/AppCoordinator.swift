//
//  AppCoordinator.swift
//  PhotographyApp
//
//  Created by Elsever on 13.03.25.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var window: UIWindow?
    
    init(navigationController: UINavigationController, window: UIWindow?) {
        self.navigationController = navigationController
        self.window = window
    }
    
    func start() {
        GoToHome()
    }
    
    func GoToHome() {
        let controller = TabBarController()
        window?.rootViewController = UINavigationController(rootViewController: controller)
        window?.makeKeyAndVisible()
    }
    
    func login() {
        let controller = LoginController()
        window?.rootViewController = UINavigationController(rootViewController: controller)
        window?.makeKeyAndVisible()
    }
    
}

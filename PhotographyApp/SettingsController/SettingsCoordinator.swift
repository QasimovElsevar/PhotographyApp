//
//  SettingsCoordinator.swift
//  PhotographyApp
//
//  Created by Elsever on 02.04.25.
//

import Foundation
import UIKit

class SettingsCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = SettingsViewController()
        navigationController.present(controller, animated: true)
    }
    
    
}

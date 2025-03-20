//
//  RegisterCoordinator.swift
//  PhotographyApp
//
//  Created by Elsever on 20.03.25.
//

import Foundation
import UIKit
class RegisterCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = RegisterController()
        navigationController.show(controller, sender: nil)
    }
}

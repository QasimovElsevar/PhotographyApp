//
//  UploadCoordinator.swift
//  PhotographyApp
//
//  Created by Elsever on 18.04.25.
//

import UIKit

class UploadCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("coo")
    }
    
    func showUploadController() {
        let controller = UploadController()
        navigationController.show(controller, sender: nil)
    }
    
    func showSubmitController() {
        let controller = PhotoSubmitController()
        navigationController.show(controller, sender: nil)
    }
    
}

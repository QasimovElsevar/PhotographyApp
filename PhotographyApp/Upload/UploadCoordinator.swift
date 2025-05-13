//
//  UploadCoordinator.swift
//  PhotographyApp
//
//  Created by Elsever on 18.04.25.
//

import UIKit

final class UploadCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var image: [UIImage]
    
    init(navigationController: UINavigationController, image: [UIImage]) {
        self.navigationController = navigationController
        self.image = image
    }
    
    func start() {
        let controller = UploadController()
        navigationController.show(controller, sender: nil)
    }
    
    func showSubmitController() {
        let controller = PhotoSubmitController(viewModel: .init(image: image))
        navigationController.setNavigationBarHidden(false, animated: true)
        navigationController.show(controller, sender: nil)
    }
}

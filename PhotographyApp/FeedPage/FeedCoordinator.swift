//
//  FeedCoordinator.swift
//  PhotographyApp
//
//  Created by Elsever on 14.04.25.
//

import UIKit

class FeedCoordinator: Coordinator {
    var navigationController: UINavigationController
    var id: String
    
    init(navigationController: UINavigationController, id: String) {
        self.navigationController = navigationController
        self.id = id
    }
    
    func start() {
        print("ffff")
    }
    
    func showImageController() {
        let controller = ImageController(viewModel: .init(photoId: id))
        controller.hidesBottomBarWhenPushed = true
        navigationController.show(controller, sender: nil)
    }
}

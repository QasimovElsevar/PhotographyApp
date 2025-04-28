//
//  FeedCoordinator.swift
//  PhotographyApp
//
//  Created by Elsever on 14.04.25.
//

import UIKit

class FeedCoordinator: Coordinator {
    var navigationController: UINavigationController
    var usersCollection: UsersCollections?
    var id: String
    
    init(navigationController: UINavigationController, id: String, usersCollection: UsersCollections? = nil) {
        self.navigationController = navigationController
        self.usersCollection = usersCollection
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
    
    func showAddToCollectionController() {
        let controller = AddToCollectionController(viewModel: .init(photoId: id, userCollection: usersCollection ?? nil))
        let navController = UINavigationController(rootViewController: controller)
        navigationController.present(navController, animated: true)
    }
}

//
//  FeedCoordinator.swift
//  PhotographyApp
//
//  Created by Elsever on 14.04.25.
//

import UIKit

class FeedCoordinator: Coordinator {
    var navigationController: UINavigationController
    var photos: UsersPhotos?
    var callback: (() -> Void)?
    var id: String?
    
    init(navigationController: UINavigationController, id: String? = "" , photos: UsersPhotos? = nil) {
        self.navigationController = navigationController
        self.photos = photos
        self.id = id
    }
    
    func start() {
        print("ffff")
    }
    
    func showImageController() {
        let controller = ImageController(viewModel: .init(photoId: id ?? ""))
        controller.hidesBottomBarWhenPushed = true
        navigationController.show(controller, sender: nil)
    }
    
    func showAddToCollectionController() {
        let controller = AddToCollectionController(viewModel: .init(photoId: id ?? "", photo: photos ?? nil))
        let navController = UINavigationController(rootViewController: controller)
        navigationController.present(navController, animated: true)
    }
    
    func showNewCollectionController() {
        let controller = NewCollectionController(viewModel: .init(photo: photos ?? nil))
        let navController = UINavigationController(rootViewController: controller)
        controller.viewModel.callBack = {
            self.callback?()
        }
        navigationController.present(navController, animated: true)
    }
}

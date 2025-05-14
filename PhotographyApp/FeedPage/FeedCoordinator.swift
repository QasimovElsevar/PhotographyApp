//
//  FeedCoordinator.swift
//  PhotographyApp
//
//  Created by Elsever on 14.04.25.
//

import UIKit

final class FeedCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var photos: UsersPhotos?
    var photo: PhotoDetails?
    var callback: (() -> Void)?
    var id: String?
    
    init(navigationController: UINavigationController,
         id: String? = "" ,
         photos: UsersPhotos? = nil,
         photo: PhotoDetails? = nil,
         usersPhotos: Bool? = false) {
        self.navigationController = navigationController
        self.photos = photos
        self.id = id
        self.photo = photo
    }
    
    func start() {
        let controller = ImageController(viewModel: .init(photoId: id ?? ""))
        controller.hidesBottomBarWhenPushed = true
        navigationController.show(controller, sender: nil)
    }
    
    func showAddToCollectionController() {
        let controller = NewPhotoToCollectionController(viewModel: .init(photoId: id ?? "", photo: photos ?? nil))
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
    
    func showInfoController() {
        let controller = InfoController()
        let navController = UINavigationController(rootViewController: controller)
        navigationController.present(navController, animated: true)
    }
    
    func showPhotoInfoController() {
        let controller = PhotoInfoController(viewModel: .init(photo: photo ?? nil))
        let navController = UINavigationController(rootViewController: controller)
        navigationController.present(navController, animated: true)
    }
}

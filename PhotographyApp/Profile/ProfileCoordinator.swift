//
//  ProfileCoordinator.swift
//  PhotographyApp
//
//  Created by Elsever on 21.04.25.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var title: String
    var userArray: UserModel?
    var photos: [UsersPhotos]?
    var id: String
    
    init(navigationController: UINavigationController,
         id: String = "",
         title: String = "",
         user: UserModel? = nil,
         photos: [UsersPhotos]? = nil) {
        self.navigationController = navigationController
        self.title = title
        self.id = id
        self.userArray = user
        self.photos = photos
    }
    
    func start() {
        print("fffff")
    }
    
    func showSettingsController() {
        guard let userArray else { return }
        let controller = SettingsViewController(viewModel: .init(userDara: userArray))
        let nvConreoller = UINavigationController(rootViewController: controller)
        navigationController.present(nvConreoller, animated: true)
    }
    
    func showUserCollectionController() {
        let controller = UserCollectionController(viewModel: .init(title: title, photos: photos ?? nil))
        navigationController.show(controller, sender: nil)
    }
    
    func showImageController() {
        let controller = ImageController(viewModel: .init(photoId: id))
        controller.hidesBottomBarWhenPushed = true
        navigationController.show(controller, sender: nil)
    }
    
    func showProfileEditingController() {
        guard let userArray else { return }
        let controller = ProfileEditingController(viewModel: .init(userArray: userArray))
        navigationController.show(controller, sender: nil)
    }
    
    func showAccountCoordinator() {
        let controller = AccountController()
        navigationController.show(controller, sender: nil)
    }
}

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
    var isUsersPhotos: Bool?
    var photos: [UsersPhotos]?
    var id: String
    
    init(navigationController: UINavigationController,
         id: String = "",
         title: String = "",
         user: UserModel? = nil,
         photos: [UsersPhotos]? = nil,
         usersPhotos: Bool? = false) {
        self.navigationController = navigationController
        self.title = title
        self.id = id
        self.userArray = user
        self.photos = photos
        self.isUsersPhotos = usersPhotos
    }
    
    func start() {
        guard let userArray else { return }
        let controller = SettingsViewController(viewModel: .init(userDara: userArray))
        let nvConreoller = UINavigationController(rootViewController: controller)
        navigationController.present(nvConreoller, animated: true)
    }
    
    func showUserCollectionController() {
        let controller = UserCollectionController(viewModel: .init(collectoinsId: id))
        navigationController.show(controller, sender: nil)
    }
    
    func showImageController() {
        let controller = ImageController(viewModel: .init(photoId: id, userPhotos: isUsersPhotos))
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

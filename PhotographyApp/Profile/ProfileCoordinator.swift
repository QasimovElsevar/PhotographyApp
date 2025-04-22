//
//  ProfileCoordinator.swift
//  PhotographyApp
//
//  Created by Elsever on 21.04.25.
//

import UIKit

class ProfileCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var title: String
    var userArray: UserModel
    var id: String
    
    init(navigationController: UINavigationController, id: String, title: String, userArray: UserModel) {
        self.navigationController = navigationController
        self.title = title
        self.id = id
        self.userArray = userArray
    }
    
    func start() {
        print("fffff")
    }
    
    func showSettingsController() {
        let controller = SettingsViewController(viewModel: .init(userDara: userArray))
        let nvConreoller = UINavigationController(rootViewController: controller)
        navigationController.present(nvConreoller, animated: true)
    }
    
    func showUserCollectionController() {
        let controller = UserCollectionController(viewModel: .init(id: id, title: title))
        navigationController.show(controller, sender: nil)
    }
    
    func showImageController() {
        let controller = ImageController(viewModel: .init(photoId: id))
        controller.hidesBottomBarWhenPushed = true
        navigationController.show(controller, sender: nil)
    }
    
    func showProfileEditingController() {
            let controller = ProfileEditingController(viewModel: .init(userArray: userArray))
        navigationController.show(controller, sender: nil)
    }
}

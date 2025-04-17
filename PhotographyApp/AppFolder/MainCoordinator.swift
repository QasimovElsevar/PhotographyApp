//
//  File.swift
//  PhotographyApp
//
//  Created by Elsever on 12.04.25.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var window: UIWindow?

    var photoId: String?
    
    init(navigationController: UINavigationController/*, photoId: Int*/) {
        self.navigationController = navigationController
//        self.photoId = photoId
    }
    
    private func setupTabBarController() {
        let tabBarComtroller = TabBarController()
        window?.rootViewController = tabBarComtroller
        window?.makeKeyAndVisible()
    }
    
    func start() {
        setupTabBarController()
    }
    
    func showFeedController() {
        let controller = FeedController()
        navigationController.show(controller, sender: nil)
    }
    
    func showInfoController() {
        let controller = InfoController()
        let searchNav = UINavigationController(rootViewController: controller)
        navigationController.present(searchNav, animated: true)
    }
    
    func showImageController() {
        let controller = ImageController(viewModel: .init(photoId: photoId ?? ""))
        controller.hidesBottomBarWhenPushed = true
        navigationController.show(controller, sender: nil)
    }
    
    func showSearchController() {
        let controller = SearchController()
        navigationController.show(controller, sender: nil)
    }
    
    func showUploadController() {
        let controller = UploadController()
        navigationController.show(controller, sender: nil)
    }
    
    func showLoginCOntroller() {
        let controller = LoginController()
        navigationController.show(controller, sender: nil)
    }
    
    func showProfileController() {
        let controller = ProfileController()
        navigationController.show(controller, sender: nil)
    }
    
    func showSubmitController() {
        let controller = PhotoSubmitController()
        navigationController.show(controller, sender: nil)
    }
}

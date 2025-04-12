//
//  TabBarController.swift
//  PhotographyApp
//
//  Created by Elsever on 13.03.25.
//

import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        tabBar.backgroundColor = .myBackground
//        createTab()
        
        setupNavigationTabs()
        //tanBarController.viewController = [
    }
    
    func setupNavigationTabs() {
        setupTabBarAppearance()
        createTab()
    }
    

    func createHome() -> UINavigationController {
        let searchController = FeedController()
        let searchNav = UINavigationController(rootViewController: searchController)
        searchController.viewModel.coordinator = MainCoordinator(navigationController: searchNav)
        let tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        searchController.tabBarItem = tabBarItem
        return searchNav
    }
    
    func createFeed() -> UINavigationController {
        let searchController = SearchController()
        let searchNav = UINavigationController(rootViewController: searchController)
        searchController.viewModel.coordinator = MainCoordinator(navigationController: searchNav)
        let tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass.fill")
        )
        searchController.tabBarItem = tabBarItem
        return searchNav
    }
    
    func createloadController() -> UINavigationController {
        let uploadController = UploadController()
        let uploadNav = UINavigationController(rootViewController: uploadController)
        uploadController.viewModel.coordinator = MainCoordinator(navigationController: uploadNav)
        let tabBarItem = UITabBarItem(
            title: "Upload",
            image: UIImage(systemName: "photo"),
            selectedImage: UIImage(systemName: "photo")
        )
        uploadController.tabBarItem = tabBarItem
        return uploadNav
    }
    
    func createLogin() -> UINavigationController {
        let loginController = LoginController()
        let loginNav = UINavigationController(rootViewController: loginController)
        loginController.viewModel.coordinator = MainCoordinator(navigationController: loginNav)
        let tabBarItem = UITabBarItem(
            title: "Login",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        loginController.tabBarItem = tabBarItem
        return loginNav
    }
    
    func createProfile() -> UINavigationController {
        let profileController = ProfileController()
        let profileNav = UINavigationController(rootViewController: profileController)
        profileController.viewModel.coordinator = MainCoordinator(navigationController: profileNav)
        let tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        profileController.tabBarItem = tabBarItem
        
//        UINavigationBar.appearance().backgroundColor = .myBackground
//        UINavigationBar.appearance().isTranslucent = false
//        UINavigationBar.appearance().tintColor = .label
        return profileNav
    }
    
    func setupTabBarAppearance() {
        UITabBar.appearance().backgroundColor = .myBackground
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = .myBackground
        UITabBar.appearance().tintColor = .label
        
        UINavigationBar.appearance().backgroundColor = .myBackground
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = .label
    }
    
    func createTab() {
        if UserDefaults.standard.string(forKey: "userID") == nil{
            self.viewControllers = [createHome(), createFeed(), createloadController(), createLogin()]
        } else {
            self.viewControllers = [createHome(), createFeed(), createloadController(), createProfile()]
        }
    }
//    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        if let navController = viewController as? UINavigationController,
//            let topVC = navController.topViewController {
//            topVC.title = "New Title"
//        }
//    }
}

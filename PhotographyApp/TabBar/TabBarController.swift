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
        setupNavigationTabs()
    }
    
    func setupNavigationTabs() {
        tabBar.backgroundColor = .myBackground
        setupTabBarAppearance()
        createTab()
    }
    
    func createHome() -> UINavigationController {
        let searchController = FeedController()
        let searchNav = UINavigationController(rootViewController: searchController)
        let tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(systemName: "photo"),
            selectedImage: UIImage(systemName: "photo.fill")
        )
        searchController.tabBarItem = tabBarItem
        return searchNav
    }
    
    func createFeed() -> UINavigationController {
        let searchController = SearchController()
        let searchNav = UINavigationController(rootViewController: searchController)
        let tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass.fill")
        )
        searchController.tabBarItem = tabBarItem
        return searchNav
    }
    
    func createloadController() -> UINavigationController {
        let uploadController = UploadController()
        let uploadNav = UINavigationController(rootViewController: uploadController)
        let tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(systemName: "plus.app.fill"),
            selectedImage: UIImage(systemName: "plus.app.fill")
        )
        uploadController.tabBarItem = tabBarItem
        return uploadNav
    }
    
    func createLogin() -> UINavigationController {
        let loginController = LoginController()
        let loginNav = UINavigationController(rootViewController: loginController)
        let tabBarItem = UITabBarItem(
            title: "",
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
            title: "",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        profileController.tabBarItem = tabBarItem
        
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
}

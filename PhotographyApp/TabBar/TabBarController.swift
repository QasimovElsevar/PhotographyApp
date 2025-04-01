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
        createTab()
    }

    func createHome() -> UIViewController {
        let tab = SearchController()
        let tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        tab.tabBarItem = tabBarItem
        return tab
    }
    
    func createFeed()  -> UIViewController {
        let tab = SearchController()
        let tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "book.closed"), selectedImage: UIImage(systemName: "book.closed.fill"))
        tab.tabBarItem = tabBarItem
        return tab

    }
    
    func createloadController()  -> UIViewController{
        let tab = UploadController()
        let tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "photo"), selectedImage: UIImage(systemName: "photo"))
        tab.tabBarItem = tabBarItem
        return tab

    }
    
    func createLogin()  -> UIViewController {
        let tab = LoginController()
        let tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        tab.tabBarItem = tabBarItem
        return tab

    }
    
    func createProfile()  -> UIViewController {
        let tab = ProfileController()
        let tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        tab.tabBarItem = tabBarItem
        return tab
    }
    
    func goToProfile() {
        if let tabBarVC = self.tabBarController {
            var viewControllers = tabBarVC.viewControllers
            
            let controller = TabBarController()
            
            let profileVC = controller.createProfile()
            
            UIView.transition(with: tabBarVC.view!,
                              duration: 0.2,
                              options: .transitionCrossDissolve,
                              animations: {
                viewControllers?[3] = profileVC
                
                tabBarVC.viewControllers = viewControllers
                
                tabBarVC.selectedIndex = 3
            })
        }
    }
    
    func createTab() {
        if UserDefaults.standard.string(forKey: "userID") == nil{
            self.viewControllers = [createHome(), createFeed(), createloadController(), createLogin()]
        } else {
            self.viewControllers = [createHome(), createFeed(), createloadController(), createProfile()]
        }
        
        UITabBar.appearance().backgroundColor = .myBackground
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = .myBackground
        UITabBar.appearance().tintColor = .label
        
        UINavigationBar.appearance().backgroundColor = .myBackground
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = .label
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let navController = viewController as? UINavigationController,
            let topVC = navController.topViewController {
            topVC.title = "New Title"
        }
    }
}

//
//  TabBarController.swift
//  PhotographyApp
//
//  Created by Elsever on 13.03.25.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTab()
    }

    func createLogin() -> UIViewController {
        let tab = LoginController()
        let tabBarItem = UITabBarItem(title: "Posts", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        tab.tabBarItem = tabBarItem
        return tab
    }
    
    func createFeed()  -> UIViewController {
        let tab = LoginController()
        let tabBarItem = UITabBarItem(title: "Albums", image: UIImage(systemName: "book.closed"), selectedImage: UIImage(systemName: "book.closed.fill"))
        tab.tabBarItem = tabBarItem
        return tab

    }
    
    func createProfile()  -> UIViewController{
        let tab = LoginController()
        let tabBarItem = UITabBarItem(title: "Photos", image: UIImage(systemName: "photo"), selectedImage: UIImage(systemName: "photo"))
        tab.tabBarItem = tabBarItem
        return tab

    }
    
    func createSomething()  -> UIViewController {
        let tab = LoginController()
        let tabBarItem = UITabBarItem(title: "User", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        tab.tabBarItem = tabBarItem
        return tab

    }
    
    func createTab() {
        self.viewControllers = [createLogin(), createFeed(), createProfile(), createSomething()]
    }
}

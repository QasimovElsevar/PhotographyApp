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
        let tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        tab.tabBarItem = tabBarItem
        return tab
    }
    
    func createFeed()  -> UIViewController {
        let tab = RegisterController()
        let tabBarItem = UITabBarItem(title: "Smth", image: UIImage(systemName: "book.closed"), selectedImage: UIImage(systemName: "book.closed.fill"))
        tab.tabBarItem = tabBarItem
        return tab

    }
    
    func createloadController()  -> UIViewController{
        let tab = ProfileController()
        let tabBarItem = UITabBarItem(title: "Photos", image: UIImage(systemName: "photo"), selectedImage: UIImage(systemName: "photo"))
        tab.tabBarItem = tabBarItem
        return tab

    }
    
    func createProfile()  -> UIViewController {
        let tab = LoginController()
        let tabBarItem = UITabBarItem(title: "User", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        tab.tabBarItem = tabBarItem
        return tab

    }
    
    func createTab() {
        self.viewControllers = [createLogin(), createFeed(), createloadController(), createProfile()]
//        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
//        tabBarAppearance.configureWithDefaultBackground()
        
//        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().backgroundColor = .myBackground
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = .myBackground
        UITabBar.appearance().tintColor = .label
        
//        let navAppearance = UINavigationBarAppearance()
//        navAppearance.configureWithOpaqueBackground()
//        
//        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
        
        UINavigationBar.appearance().backgroundColor = .myBackground
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = .label
        
        
        
    }
}

//extension TabBarController {
//    func makeNavigationBar() -> UIView {
//        lazy var image: UIImageView = {
//            let image = UIImageView()
//            image.image = UIImage(named: "arrow.right")
//            image.contentMode = .scaleAspectFit
//            image.heightAnchor.constraint(equalToConstant: 50).isActive = true
//            image.widthAnchor.constraint(equalToConstant: 50).isActive = true
//            image.translatesAutoresizingMaskIntoConstraints = false
//            return image
//        }()
//        
//        lazy var spacer: UIView = {
//            let spacer = UIView()
//            spacer.widthAnchor.constraint(greaterThanOrEqualToConstant: CGFloat.greatestFiniteMagnitude).isActive = true
//            return spacer
//        }()
//        
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.backgroundColor = .gray
//        stackView.distribution = .equalSpacing
//        stackView.alignment = .fill
//        stackView.isLayoutMarginsRelativeArrangement = true
//        stackView.addArrangedSubview(image)
//        stackView.addArrangedSubview(spacer)
//        return stackView
//    }
//    
//    func addNavigationBar() -> Self {
//        let navigationBar = makeNavigationBar()
//        navigationItem.titleView = navigationBar
//        return self
//    }
//}

//extension TabBarController {
//    static func instatntiate(storyBoardName: String) -> Self {
//        let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
//        return storyBoard.instantiateViewController(withIdentifier: String(describing: self)) as! Self
//    }
//}

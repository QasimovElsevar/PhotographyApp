//
//  ProfileCotroller.swift
//  PhotographyApp
//
//  Created by Elsever on 16.03.25.
//

import UIKit

class ProfileController: UIViewController {
    
    //MARK: -UI Elements
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewModel.createLayaout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.register(ProfileCell.self, forCellWithReuseIdentifier: "ProfileCell")
        collection.register(ProfileSelectionCell.self, forCellWithReuseIdentifier: "ProfileSelectionCell")
        collection.register(ProfileCollectionCell.self, forCellWithReuseIdentifier: "ProfileCollectionCell")
        collection.register(ProfileCollectionPhotosCell.self, forCellWithReuseIdentifier: "ProfileCollectionPhotosCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }()
    
   //MARK: - Properties

    let viewModel =  ProfileViewModel()
    var index = 0
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        FireBaseManager.shared.printCurrentUser()
        getData()
    }
    
    //MARK: - UI Configuration
    
    func configure() {
        navigationBarItemConfigure()
        
        view.addSubview(collection)
        view.backgroundColor = .myBackground
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func navigationBarItemConfigure() {
        tabBarController?.navigationItem.title = "Qasimov"
        tabBarController?.navigationItem.titleView?.tintColor = .label
//        tabBarController?.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundEffect = .none

        tabBarButtonsConfigure()
    }
    
    @objc private func openMenu() {
        print("ffff")
    }
}

extension ProfileController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfCells(index: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section] {
        case .profile:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            return cell
            
        case .selection:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "ProfileSelectionCell", for: indexPath) as! ProfileSelectionCell
            cell.callback = { tag in
                self.viewModel.index = tag
                self.collection.reloadData()
            }
            return cell
            
        case .collection:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionPhotosCell", for: indexPath) as! ProfileCollectionPhotosCell
            cell.backgroundColor = .red
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
//  MARK: - Navigation Bar Appearance
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        tabBarController?.navigationController?.navigationBar.alpha = 0 + scrollView.contentOffset.y / 100
        
    }
}

extension ProfileController {
    
    //MARK: - Data
    func getData() {
        viewModel.getUserData()
        
        viewModel.completion = { error in
            print(error)
        }
        
        viewModel.success = {
            print("success: \(self.viewModel.userData?.firstName ?? "")")
        }
    }
}

extension ProfileController {
    
    func tabBarButtonsConfigure() {
        
        let openSettings = UIAction(title: "Account Settings") { action in
            self.openSettings()
        }
        let logOut = UIAction(title: "Log Out") { action in
            self.viewModel.logOut()
        }
        
        let menu = UIMenu(children: [openSettings, logOut])
        
        let menuButton: UIBarButtonItem = {
            let button = UIBarButtonItem()
            button.image = UIImage(systemName: "ellipsis")
            button.menu = menu
            return button
        }()
        
        let shareButton: UIBarButtonItem = {
            let button = UIBarButtonItem()
            button.image = UIImage(systemName: "square.and.arrow.up")
            button.target = self
            button.action = #selector(shareButtonTapped)
            return button
        }()
        
        
        tabBarController?.navigationItem.rightBarButtonItems = [shareButton, menuButton]
    }
    
    //MARK: - Menu Actions
    
    func openSettings() {
        let coordinator = SettingsCoordinator(navigationController: navigationController ?? UINavigationController())
        coordinator.start()
    }
    
    func goToProfile() {
        if let tabBarVC = self.tabBarController {
            var viewControllers = tabBarVC.viewControllers
            
            let controller = TabBarController()
            
            let profileVC = controller.createLogin()
            
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
    
    //MARK: - BarButton Action
    
    @objc func shareButtonTapped() {
        let items = [URL(string: "")!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
}

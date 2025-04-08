//
//  ProfileCotroller.swift
//  PhotographyApp
//
//  Created by Elsever on 16.03.25.
//

import UIKit

class ProfileController: UIViewController {
    
    //MARK: - UI Elements
    
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
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView()
        loadingView.style = .medium
        loadingView.color = .label
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
   //MARK: - Properties

    let viewModel =  ProfileViewModel()
    var index = 0
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        FireBaseManager.shared.printCurrentUser()
        getData()
    }
    
    //MARK: - UI Configuration
    
    func configureUI() {
        view.backgroundColor = .myBackground
        
        addSubviews()
        setCostraints()
        navigationBarConfigure()
        bindViewModel()
        configureTabBar()
    }
    
    private func navigationBarConfigure() {
        tabBarController?.navigationItem.title = "Qasimov"
        tabBarController?.navigationItem.titleView?.tintColor = .label

        navigationBarButtonsConfigure()
    }
    
    private func addSubviews() {
        view.addSubview(collection)
        view.addSubview(loadingView)
    }
    
    private func configureTabBar() {
        tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
    }
    
    private func setCostraints() {
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
     //MARK: - UI Actions
    
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
//            print("success: \(self.viewModel.userData?.firstName ?? "")")
        }
    }
    
    private func bindViewModel() {
        viewModel.stateUpdate = { [weak self] state in
            
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                switch state {
                case .loading:
                    loadingView.startAnimating()
                case  .loaded:
                    loadingView.stopAnimating()
                case .success:
                    print("success")
                case .error:
                    print("error")
                case .idle:
                    break
                }
                
            }
        }
    }
}

extension ProfileController {
    
    func navigationBarButtonsConfigure() {
        
        let openSettings = UIAction(title: "Account Settings") { action in
            self.openSettings()
        }
        let logOut = UIAction(title: "Log Out") { action in
            FireBaseManager.shared.signOut()
            self.goToProfile()
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
            
            let profileVC = LoginController()
            
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

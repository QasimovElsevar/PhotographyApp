//
//  ProfileCotroller.swift
//  PhotographyApp
//
//  Created by Elsever on 16.03.25.
//

import UIKit

final class ProfileController: UIViewController {
    
    //MARK: - UI Elements
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewModel.createLayaout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.register(ProfileCell.self, forCellWithReuseIdentifier: "ProfileCell")
        collection.register(ProfileSelectionCell.self, forCellWithReuseIdentifier: "ProfileSelectionCell")
//        collection.register(ProfileCollectionCell.self, forCellWithReuseIdentifier: "ProfileCollectionCell")
        collection.register(ImageWithLabelCell.self, forCellWithReuseIdentifier: "ImageWithLabelCell")
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
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        FireBaseManager.shared.printCurrentUser()
        
    }
    
    //MARK: - UI Configuration
    
    func configureUI() {
        view.backgroundColor = .profile
        
        addSubviews()
        setCostraints()
        navigationBarConfigure()
        getData()
        bindViewModel()
        configureTitle()
    }
    
    private func navigationBarConfigure() {
//        navigationItem.titleView?.tintColor = .label
//        navigationItem.titleView?.alpha = 0
        navigationController?.navigationBar.backgroundColor = .profile.withAlphaComponent(0.8)
//        navigationController?.isNavigationBarHidden = true
//        UINavigationBar.appearance().backgroundColor?.withAlphaComponent(0)
//        UINavigationBar.appearance().backgroundColor = .profile.withAlphaComponent(0)
//        UINavigationBar.appearance().isTranslucent = false
//        UINavigationBar.appearance().tintColor = .label
        
        UINavigationBar.appearance().backgroundColor = .myBackground
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = .label
        navigationItem.title = "Elsever"
        navigationBarButtonsConfigure()
    }
    
    private func addSubviews() {
        view.addSubview(collection)
        view.addSubview(loadingView)
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
            cell.configure(firstName: viewModel.userData?.firstName ?? "", lastName: viewModel.userData?.lastName ?? "")
            return cell
            
        case .selection:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "ProfileSelectionCell", for: indexPath) as! ProfileSelectionCell
            cell.callback = { tag in
                self.viewModel.index = tag
                self.getData()
            }
            return cell
            
        case .collection:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "ImageWithLabelCell", for: indexPath) as! ImageWithLabelCell
            
            switch viewModel.selections[viewModel.index] {
            case .photos:
                cell.configure(data: viewModel.userPhotos[indexPath.row].urls?.regular ?? "", text: "")
            case .likes:
                cell.configure(data: viewModel.userPhotos[indexPath.row].urls?.regular ?? "", text: viewModel.userPhotos[indexPath.row].user?.name ?? "")
            case .collections:
                cell.configure(data: viewModel.userPhotos[indexPath.row].urls?.regular ?? "", text: "")
            }
            
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.index == 0 || viewModel.index == 1 {
            let coordinator = MainCoordinator(navigationController: navigationController ?? UINavigationController())
            coordinator.photoId = viewModel.userPhotos[indexPath.row].id
            coordinator.showImageController()
        }
    }
    
//  MARK: - Navigation Bar Appearance
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//            navigationController?.isNavigationBarHidden = false
//            UINavigationBar.appearance().backgroundColor?.withAlphaComponent(0 + scrollView.contentOffset.y / 100)
            navigationController?.navigationBar.backgroundColor  = .profile.withAlphaComponent(0.5)
//        } else {
//            navigationController?.isNavigationBarHidden = true

//        }
    }
}

extension ProfileController {
    
    //MARK: - Data
    
    private func getData() {
        Task {
            await viewModel.getUserData()
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
                    collection.reloadData()
                case .error(let error):
                    print(error)
                case .idle:
                    break
                }
                
            }
        }
    }
}

extension ProfileController {
    //MARK: - navigationController Configuration
    
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
        
        
        navigationItem.rightBarButtonItems = [shareButton, menuButton]
    }
    
    func configureTitle() {
        navigationController?.navigationBar.titleTextAttributes = [
                .font: UIFont.boldSystemFont(ofSize: 18) // Change the size if needed
            ]
        
        navigationController?.title = "Photography"
    }
    
    //MARK: - Menu Actions
    
    func openSettings() {
        let coordinator = SettingsCoordinator(navigationController: navigationController ?? UINavigationController())
        coordinator.start()
    }
    
    func goToProfile() {
        if let tabBarVC = self.tabBarController {
            var viewControllers = tabBarVC.viewControllers
            let tabController = TabBarController()
            
            let profileVC = tabController.createLogin()
            
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

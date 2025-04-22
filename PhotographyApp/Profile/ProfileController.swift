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
        collection.register(MyCollectionsCell.self, forCellWithReuseIdentifier: "MyCollectionsCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }()
    
    private lazy var additionalView: UIView = {
        let view = UIView()
        view.backgroundColor = .profile
        view.autoresizingMask = [.flexibleWidth]
        return view
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
        viewModel.getUser()
        let topInset = view.safeAreaInsets.top
        
        let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: topInset))
        statusBarView.backgroundColor = UIColor.profile
        view.addSubview(statusBarView)
        configureUI()
        //        if let navBar = navigationController?.navigationBar {
        //            view.insertSubview(additionalView, belowSubview: navBar)
        //            } else {
        //                view.addSubview(additionalView)
        //            }
        // Make background transparent
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        //            navigationController?.navigationBar.alpha = 1
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .profile
        edgesForExtendedLayout = [.top]
        
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 100))
        backgroundView.backgroundColor = UIColor.red.withAlphaComponent(0) // or any color with alpha
        view.addSubview(backgroundView)
        
    }
    
    //MARK: - UI Configuration
    
    func configureUI() {
        view.backgroundColor = .myBackground
        navigationController?.navigationBar.backgroundColor = .profile
        addSubviews()
        setCostraints()
        navigationBarConfigure()
        getData()
        bindViewModel()
        configureTitle()
    }
    
    private func navigationBarConfigure() {
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
            
            switch viewModel.selections[viewModel.index] {
            case .photos:
                let cell = collection.dequeueReusableCell(withReuseIdentifier: "ImageWithLabelCell", for: indexPath) as! ImageWithLabelCell
                cell.configure(data: viewModel.userPhotos[indexPath.row].urls?.regular ?? "", text: "")
                return cell
            case .likes:
                let cell = collection.dequeueReusableCell(withReuseIdentifier: "ImageWithLabelCell", for: indexPath) as! ImageWithLabelCell
                cell.configure(data: viewModel.userPhotos[indexPath.row].urls?.regular ?? "", text: viewModel.userPhotos[indexPath.row].user?.name ?? "")
                return cell
            case .collections:
                let cell = collection.dequeueReusableCell(withReuseIdentifier: "MyCollectionsCell", for: indexPath) as! MyCollectionsCell
                let collection = viewModel.userCollections[indexPath.row]
                cell.configure(photos: collection.previewPhotos ?? [], itemCount: collection.totalPhotos ?? 0, name: collection.title ?? "")
                return cell
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (viewModel.index == 0 || viewModel.index == 1) && indexPath.section == 2 {
            showImageController(indexPath: indexPath.row)
        } else if viewModel.index == 2 && indexPath.section == 2 {
            showUserCollectionController(indexPath: indexPath.row)
        }
    }
    
    func showImageController(indexPath: Int) {
        let coordinator = ProfileCoordinator(navigationController: navigationController ?? UINavigationController(), id: viewModel.userPhotos[indexPath].id ?? "", title: "", userArray: viewModel.userData! )
        coordinator.showImageController()
    }
    
    func showUserCollectionController(indexPath: Int) {
        let coordinator = ProfileCoordinator(navigationController: navigationController ?? UINavigationController(), id: viewModel.userCollections[indexPath].id ?? "", title: viewModel.userCollections[indexPath].title ?? "", userArray: viewModel.userData!)
        coordinator.showUserCollectionController()
    }
    
    
    //  MARK: - Navigation Bar Appearance
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        navigationController?.navigationBar.alpha = 0 + scrollView.contentOffset.y / 100
        navigationController?.navigationBar.backgroundColor = .myBackground.withAlphaComponent(0 + scrollView.contentOffset.y / 100)
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
                    navigationItem.title = "\(viewModel.userData?.firstName ?? "") \(viewModel.userData?.lastName ?? "")"
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
            .font: UIFont.boldSystemFont(ofSize: 18)
        ]
        
        navigationController?.title = "Photography"
    }
    
    //MARK: - Menu Actions
    
    func openSettings() {
        guard let data = viewModel.userData else { return }
        let coordinator = ProfileCoordinator(navigationController: navigationController ?? UINavigationController(), id: "", title: "", userArray: data)
        coordinator.showSettingsController()
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

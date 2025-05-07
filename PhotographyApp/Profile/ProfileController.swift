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
        collection.refreshControl = refreshControl
        collection.contentInsetAdjustmentBehavior = .never
        collection.register(ProfileCell.self, forCellWithReuseIdentifier: "ProfileCell")
        collection.register(ProfileSelectionCell.self, forCellWithReuseIdentifier: "ProfileSelectionCell")
        collection.register(ImageWithLabelCell.self, forCellWithReuseIdentifier: "ImageWithLabelCell")
        collection.register(MyCollectionsCell.self, forCellWithReuseIdentifier: "MyCollectionsCell")
        collection.register(TransparentViewCell.self, forCellWithReuseIdentifier: "TransparentViewCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView()
        loadingView.style = .medium
        loadingView.color = .label
        loadingView.startAnimating()
        loadingView.backgroundColor = .myBackground
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        view.alpha = 0
        view.backgroundColor = .myBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refresh
    }()
    
    //MARK: - Properties
    
    let viewModel =  ProfileViewModel()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getUser()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navBarConfigure()
    }
    
    //MARK: - UI Configuration
    
    func configureUI() {
        view.backgroundColor = .myBackground
        navigationController?.navigationBar.backgroundColor = .profile
        addSubviews()
        setCostraints()
        navigationBarButtonsConfigure()
        getData()
        bindViewModel()
        configureTitle()
    }
    
    private func addSubviews() {
        view.addSubview(collection)
        view.addSubview(loadingView)
    }
    
    private func setCostraints() {
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
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
            cell.configure(username: viewModel.userData?.username ?? "")
            cell.callback = {
                let coordinator = ProfileCoordinator(navigationController: self.navigationController!, user: self.viewModel.userData)
                coordinator.showProfileEditingController()
            }
            return cell
        case .selection:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "ProfileSelectionCell", for: indexPath) as! ProfileSelectionCell
            cell.callback = { tag in
                self.viewModel.index = tag
                self.collection.reloadSections(IndexSet(integer: 2))
                self.getData()
            }
            return cell
            
        case .collection:
            switch viewModel.selections[viewModel.index] {
            case .photos:
                if viewModel.userPhotos.isEmpty {
                    let cell = collection.dequeueReusableCell(withReuseIdentifier: "TransparentViewCell", for: indexPath) as! TransparentViewCell
                    cell.configure(text: "No photos")
                    return cell
                } else {
                    let cell = collection.dequeueReusableCell(withReuseIdentifier: "ImageWithLabelCell", for: indexPath) as! ImageWithLabelCell
                    let photos = viewModel.userPhotos[indexPath.row]
                    cell.configure(data: photos.url ?? "", text: "", blurHash: photos.blurHash ?? "")
                    return cell
                }
            case .likes:
                if viewModel.userLiked.isEmpty {
                    let cell = collection.dequeueReusableCell(withReuseIdentifier: "TransparentViewCell", for: indexPath) as! TransparentViewCell
                    cell.configure(text: "No liked photos")
                    return cell
                } else {
                    let cell = collection.dequeueReusableCell(withReuseIdentifier: "ImageWithLabelCell", for: indexPath) as! ImageWithLabelCell
                    let photos = viewModel.userLiked[indexPath.row]
                    cell.configure(data: photos.url ?? "" , text: photos.author ?? "", blurHash: "")
                    return cell
                }
            case .collections:
                if viewModel.userCollections.isEmpty {
                    let cell = collection.dequeueReusableCell(withReuseIdentifier: "TransparentViewCell", for: indexPath) as! TransparentViewCell
                    cell.configure(text: "No collections")
                    return cell
                } else {
                    let cell = collection.dequeueReusableCell(withReuseIdentifier: "MyCollectionsCell", for: indexPath) as! MyCollectionsCell
                    let collection = viewModel.userCollections[indexPath.row]
                    cell.configure(photos: collection.photos, itemCount: 5, name: collection.collectionName ?? "")
                    return cell
                }
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (viewModel.index == 1) && indexPath.section == 2 {
            let id = viewModel.userLiked[indexPath.row].id ?? ""
            showImageController(photoId: id)
        } else if viewModel.index == 0 && indexPath.section == 2 {
            let id = viewModel.userPhotos[indexPath.row].id ?? ""
            showImageController(photoId: id )
        } else if viewModel.index == 2 && indexPath.section == 2 {
            showUserCollectionController(indexPath: indexPath.row)
        }
    }
    
    func showImageController(photoId: String) {
        let coordinator = ProfileCoordinator(navigationController: navigationController ?? UINavigationController(), id: photoId, user: viewModel.userData!  )
        coordinator.showImageController()
    }
    
    func showUserCollectionController(indexPath: Int) {
        //        let coordinator = ProfileCoordinator(navigationController: navigationController ?? UINavigationController(), id: viewModel.userCollections[indexPath].id ?? "", title: viewModel.userCollections[indexPath].title ?? "", user: viewModel.userData!)
        //        coordinator.showUserCollectionController()
    }
    
    
    //  MARK: - Navigation Bar Appearance
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        backgroundView.alpha = 0 + scrollView.contentOffset.y / 100
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
                    navigationItem.title = "\(viewModel.userData?.firstname ?? "") \(viewModel.userData?.lastname ?? "")"
                    collection.refreshControl?.endRefreshing()
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
    
    func navBarConfigure() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .none
        edgesForExtendedLayout = [.top]
    }
    
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
        let coordinator = ProfileCoordinator(navigationController: navigationController ?? UINavigationController(), id: "", title: "", user: data)
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
    
    @objc private func shareButtonTapped() {
        let items = [URL(string: viewModel.userData?.username ?? "")!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @objc private func handleRefresh() {
        getData()
    }
}

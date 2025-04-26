//
//  UserCollectionController.swift
//  PhotographyApp
//
//  Created by Elsever on 19.04.25.
//

import UIKit

class UserCollectionController: UIViewController {
    
    //MARK: - UI Elemenets
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewModel.createLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.register(ImageWithLabelCell.self, forCellWithReuseIdentifier: "ImageWithLabelCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    //MARK: Properties
    
    let viewModel: UserCollectionViewModel
    
    init(viewModel: UserCollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lyfcycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getData()
    }
    
    //MARK: - Configure UI
    
    private func configureUI() {
        view.backgroundColor = .myBackground
        view.addSubview(collection)
        setConstraints()
        bindViewModel()
        configureNavButtons()
        statusBarConfigure()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func statusBarConfigure() {
        view.createStatusBarCover(mainView: view)
        view.makeNavBarTransparent(navController: navigationController ?? UINavigationController())
        edgesForExtendedLayout = [.top]
    }
}

extension UserCollectionController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Collection
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "ImageWithLabelCell", for: indexPath) as! ImageWithLabelCell
        let list = viewModel.photos[indexPath.row]
        cell.configure(data: list.urls?.regular ?? "", text: list.user?.name ?? "", blurHash: list.blurHash ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coordinator = ProfileCoordinator(
            navigationController: navigationController ?? UINavigationController(),
            id: viewModel.photos[indexPath.row].id ?? "",
            title: "",
            user: UserModel.init(
                firstName: "",
                lastName: "",
                username: "",
                email: "",
                accessKey: ""
            )
        )
        coordinator.showImageController()
    }
}

extension UserCollectionController {
    
    private func bindViewModel() {
        viewModel.stateUpdate = { [weak self] state in
            
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                switch state {
                case .loading:
                    //                  loadingView.startAnimating()
                    print("ff")
                case  .loaded:
                    //                    loadingView.stopAnimating()
                    print("ff")
                case .success:
                    print("success")
                    collection.reloadData()
                case .error(let error):
                    print(error)
                case .idle:
                    break
                }
                
            }
        }
    }
    
    func getData() {
        Task {
            await viewModel.getCollection()
        }
    }
    
    func configureNavButtons() {
        let openSettings = UIAction(title: "Account Settings") { action in
            //            self.openSettings()
        }
        let logOut = UIAction(title: "Log Out") { action in
            FireBaseManager.shared.signOut()
            //            self.goToProfile()
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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),style: .plain, target: self, action: #selector(handleDismiss))
        navigationItem.title = viewModel.title
        
        navigationItem.rightBarButtonItems = [shareButton, menuButton]
    }
    
    //MARK: - NavButtons Actions
    
    @objc func shareButtonTapped() {
        let items = [URL(string: "")!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @objc private func handleDismiss() {
        navigationController?.popViewController(animated: true)
    }
    
}

//
//  UserCollectionController.swift
//  PhotographyApp
//
//  Created by Elsever on 19.04.25.
//

import UIKit

final class UserCollectionController: UIViewController {
    
    //MARK: - UI Elemenets
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewModel.createLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.refreshControl = refreshControl
        collection.register(ImageWithLabelCell.self, forCellWithReuseIdentifier: "ImageWithLabelCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView()
        loadingView.style = .medium
        loadingView.color = .label
        loadingView.backgroundColor = .myBackground
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(handeRefresh), for: .valueChanged)
        return refresh
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getCollection()
    }
    
    //MARK: - Configure UI
    
    private func configureUI() {
        view.backgroundColor = .myBackground
        view.addSubview(collection)
        view.addSubview(loadingView)
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
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
        viewModel.userCollections?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "ImageWithLabelCell", for: indexPath) as! ImageWithLabelCell
        let list = viewModel.userCollections?.photos[indexPath.row]
        cell.configure(data: list?.url ?? "", text: list?.author ?? "", blurHash: list?.blurHash ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coordinator = ProfileCoordinator(
            navigationController: navigationController ?? UINavigationController(),
            id: viewModel.userCollections?.photos[indexPath.row].id ?? ""
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
                    loadingView.startAnimating()
                case  .loaded:
                    loadingView.stopAnimating()
                case .success:
                    collection.refreshControl?.endRefreshing()
                    navigationItem.title = viewModel.userCollections?.collectionName
                    collection.reloadData()
                case .error(let error):
                    print(error)
                case .idle:
                    break
                }
                
            }
        }
    }
    
    //MARK: - Confihure NavBar
    
    func configureNavButtons() {
        
        let delete = UIAction(title: "Delete") { action in
            self.viewModel.deleteCollection()
            self.navigationController?.popViewController(animated: true)
        }
        
        let menu = UIMenu(children: [delete])
        
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
        
        navigationItem.rightBarButtonItems = [shareButton, menuButton]
    }
    
    //MARK: - NavButtons Actions
    
    @objc func shareButtonTapped() {
        let items = [URL(string: viewModel.userCollections?.collectionName ?? "")!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @objc private func handleDismiss() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handeRefresh() {
        viewModel.getCollection()
    }
}

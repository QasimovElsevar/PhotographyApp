//
//  FeedController.swift
//  PhotographyApp
//
//  Created by Elsever on 12.04.25.
//

import UIKit

final class FeedController: UIViewController {
    
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
    
    private lazy var switchLayoutButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "square.split.2x1.fill")
        button.action = #selector(switchLayout)
        return button
    }()
    
    private lazy var infoButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "camera")
        button.action = #selector(showInfo)
        return button
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
    
    let viewModel = FeedViewModel()
    var isInFourSquaresState: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureTitle()
    }
    
    private func configureUI() {
        view.addSubview(collection)
        view.addSubview(loadingView)
        statusBarConfigure()
        setConstraints()
        bindViewModel()
        configureNavButtons()
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

extension FeedController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.isLayoutChanged == false {
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "ImageWithLabelCell", for: indexPath) as! ImageWithLabelCell
            let list =  viewModel.photoList[indexPath.row]
            cell.configure(data: list.urls?.regular ?? "", text: list.user?.name ?? "", blurHash: list.blurHash ?? "")
            return cell
        } else {
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "ImageWithLabelCell", for: indexPath) as! ImageWithLabelCell
            let list =  viewModel.photoList[indexPath.row]
            cell.configure(data: list.urls?.small ?? "", text: list.user?.name ?? "", blurHash: list.blurHash ?? "")
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.photoList.count) - 1 {
            Task {
                await viewModel.getList()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coordinator = FeedCoordinator(navigationController: navigationController ?? UINavigationController(), id: viewModel.photoList[indexPath.row].id ?? "")
        coordinator.showImageController()
    }
}

extension FeedController {
    //MARK: ViewModel Binding
    
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
            await viewModel.getList()
        }
    }
}

extension FeedController {
    
    //MARK: - NavigationBar Configurations
    
    func configureTitle() {
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont(name: "impact", size: 18) ?? UIFont()
        ]
        
        navigationItem.title = "Photography"
    }
    
    func configureNavButtons() {
        switchLayoutButton.target = self
        navigationItem.rightBarButtonItem = switchLayoutButton
        infoButton.target = self
        navigationItem.leftBarButtonItem = infoButton
        
    }
    
    //MARK: - MavButton Actions
    
    @objc private func switchLayout() {
        if viewModel.isLayoutChanged == false {
            viewModel.isLayoutChanged = true
            switchLayoutButton.image = UIImage(systemName: "square.split.2x2.fill")
            collection.reloadData()
        } else {
            viewModel.isLayoutChanged = false
            switchLayoutButton.image = UIImage(systemName: "square.split.2x1.fill")
            collection.reloadData()
        }
    }
    
    @objc private func showInfo() {
        let coordinator = MainCoordinator(navigationController: navigationController ?? UINavigationController())
        coordinator.showInfoController()
    }
    
    @objc private func handeRefresh() {
        getData()
    }
}

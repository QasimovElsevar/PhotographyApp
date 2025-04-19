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
    
    
    let viewModel = FeedViewModel()
    var isInFourSquaresState: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        viewModel.getUserData()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureTitle()
    }
    
    private func configureUI() {
        view.addSubview(collection)
        setConstraints()
        bindViewModel()
        configureNavButtons()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FeedController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.isLayoutChanged == false {
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "ImageWithLabelCell", for: indexPath) as! ImageWithLabelCell
            cell.configure(data: viewModel.photoList[indexPath.row].urls?.regular ?? "", text: viewModel.photoList[indexPath.row].user?.name ?? "")
//            cell.callback = {
//                self.collection.collectionViewLayout.invalidateLayout()
//            }
            return cell
        } else {
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "ImageWithLabelCell", for: indexPath) as! ImageWithLabelCell
            cell.configure(data: viewModel.photoList[indexPath.row].urls?.small ?? "", text: viewModel.photoList[indexPath.row].user?.name ?? "")
//        cell.callback = {
//            self.collection.collectionViewLayout.invalidateLayout()
//        }
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
        let coordinator = MainCoordinator(navigationController: navigationController ?? UINavigationController())
        coordinator.photoId = viewModel.photoList[indexPath.row].id
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
}

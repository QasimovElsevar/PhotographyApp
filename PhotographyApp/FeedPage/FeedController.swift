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
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewModel.createLayaout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.register(DoubleHorizontalCell.self, forCellWithReuseIdentifier: "DoubleHorizontalCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    var customButton: UIButton!
    
    let viewModel = FeedViewModel()
    var isInFourSquaresState: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.getUserData()
        getData()

    }
    
    private func configureUI() {
        view.addSubview(collection)
        setConstraints()
        bindViewModel()
        configureTitle()
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
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "DoubleHorizontalCell", for: indexPath) as! DoubleHorizontalCell
        cell.configure(data: viewModel.photoList[indexPath.row].urls?.regular ?? "", text: viewModel.photoList[indexPath.row].user?.name ?? "")
        return cell
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
                .font: UIFont.boldSystemFont(ofSize: 18)
            ]
        
        navigationItem.title = "Photography"
    }
    
    func configureRightButton() {
        let shareButton: UIBarButtonItem = {
            let button = UIBarButtonItem()
            button.image = UIImage(systemName: "square.and.arrow.up")
            button.target = self
//            button.action = #selector()
            return button
        }()
    }
}

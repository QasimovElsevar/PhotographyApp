//
//  UploadController.swift
//  PhotographyApp
//
//  Created by Elsever on 16.03.25.
//

import UIKit
import PhotosUI

class UploadController: UIViewController {

    //  MARK: -UI Elements

    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewModel.createLayaout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.register(UploadCell.self, forCellWithReuseIdentifier: "UploadCell")
        collection.register(TextCell.self, forCellWithReuseIdentifier: "TextCell")
        collection.register(TopicsCell.self, forCellWithReuseIdentifier: "TopicsCell")
        collection.register(LatestBlogCell.self, forCellWithReuseIdentifier: "LatestBlogCell")
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
    
    let viewModel = UploadViewModel()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getData()
    }
    
    //MARK: - UI Configuration
    
    func configureUI() {
        view.backgroundColor = .myBackground
        addSubviews()
        setConstrains()
        bindViewModel()
    }
    
    func addSubviews() {
        view.addSubview(collection)
        view.addSubview(loadingView)
    }
    
    func setConstrains() {
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
}

extension UploadController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numOfCells(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section] {
        case .contributionText:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as! TextCell
            cell.configure(text: "Contribute to Unsplash", textSize: 20)
            return cell
        case .image:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "UploadCell", for: indexPath) as! UploadCell
            return cell
        case .topicText:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as! TextCell
            cell.configure(text: "Submit to topics", textSize: 16)
            return cell
        case .topics:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TopicsCell", for: indexPath) as! TopicsCell
            cell.configure(url: viewModel.topics?[indexPath.row].coverPhoto?.urls?.thumb ?? "", topic: viewModel.topics?[indexPath.row].title ?? "")
            return cell
        case .blog:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "LatestBlogCell", for: indexPath) as! LatestBlogCell
            return cell
        case .blogText:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as! TextCell
            cell.configure(text: "Latest from the blog", textSize: 16)
            return cell
        }
       
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.sections[indexPath.section] == .image {
            var config = PHPickerConfiguration()
            config.selectionLimit = 9
            
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true)
        }
    }
    
    
}

extension UploadController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true) {
            let coordinator = PhotoSubmitCoordinator(navigationController: self.navigationController ?? UINavigationController())
            coordinator.start()
        }
       
//        let controller = PhotoSubmitController()
//        navigationController?.show(controller, sender: nil)
    }
}

extension UploadController {
    func getData() {
        viewModel.getData()
        
        viewModel.failure = { error in
            print(error)
        }
        
        viewModel.success = {
            self.collection.reloadData()
            print("got it")
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

//
//  ImageController.swift
//  PhotographyApp
//
//  Created by Elsever on 14.04.25.
//

import UIKit

class ImageController: UIViewController {

    //MARK: - UI Elements
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewModel.createLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.register(ImageWithLabelCell.self, forCellWithReuseIdentifier: "ImageWithLabelCell")
        collection.register(TransparentViewCell.self, forCellWithReuseIdentifier: "TransparentViewCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var imageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var likeImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var likeButton : UIButton = {
        let button = UIButton()
//        button.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 200, height: 200))
        button.layer.cornerRadius = 30
        button.setImage(UIImage(systemName: "heart"), for: .normal) // Add your heart image asset
        button.tintColor = .systemRed
        button.backgroundColor = .myBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Properties
    
    let viewModel: ImageViewModel
    
    init(viewModel: ImageViewModel) {
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
    
    //MARK: - UI Configure
    private func configureUI() {
        view.backgroundColor = .myBackground
        addSubviews()
        setConstraints()
        bindViewModel()
    }
    
    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(collection)
        view.addSubview(likeButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            likeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            likeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])
    }
}

extension ImageController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems(sections: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section] {
        case .mainPhoto:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TransparentViewCell", for: indexPath) as! TransparentViewCell
            return cell
        case .relatedPhotos:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "ImageWithLabelCell", for: indexPath) as! ImageWithLabelCell
            cell.configure(data: viewModel.photoResultArray[indexPath.row].urls?.regular ?? "" , text: viewModel.photoResultArray[indexPath.row].user?.name ?? "")
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        imageView.alpha = 1 - scrollView.contentOffset.y / (view.frame.height / 1.5)
    }
}

extension ImageController {
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
                    imageView.loadImage(url: viewModel.photo?.urls?.regular ?? "")
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
            await viewModel.getPhoto()
        }
    }
}

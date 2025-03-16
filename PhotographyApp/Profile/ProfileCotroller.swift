//
//  ProfileCotroller.swift
//  PhotographyApp
//
//  Created by Elsever on 16.03.25.
//

import UIKit

class ProfileCotroller: UIViewController {

    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.register(MyCollectionsCell.self, forCellWithReuseIdentifier: "MyCollectionsCell")
        collection.register(MyLikedCell.self, forCellWithReuseIdentifier: "MyLikedCell")
        collection.register(MyPhotosCell.self, forCellWithReuseIdentifier: "MyPhotosCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = false
        return collection
    }()
    
    private lazy var downCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.register(MyCollectionsCell.self, forCellWithReuseIdentifier: "MyCollectionsCell")
        collection.register(MyLikedCell.self, forCellWithReuseIdentifier: "MyLikedCell")
        collection.register(MyPhotosCell.self, forCellWithReuseIdentifier: "MyPhotosCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = false
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        view.addSubview(collection)
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension ProfileCotroller: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "MyCollectionsCell", for: indexPath)
        cell.backgroundColor = .systemBlue
        return cell
    }
    
    
}

//extension ProfileCotroller {
//    func makeNavigationBar() -> UIView {
//        lazy var image: UIImageView = {
//            let image = UIImageView()
//            image.image = UIImage(named: "arrow.right")
//            image.contentMode = .scaleAspectFit
//            image.heightAnchor.constraint(equalToConstant: 50).isActive = true
//            image.widthAnchor.constraint(equalToConstant: 50).isActive = true
//            image.translatesAutoresizingMaskIntoConstraints = false
//            return image
//        }()
//        
//        lazy var spacer: UIView = {
//            let spacer = UIView()
//            spacer.widthAnchor.constraint(greaterThanOrEqualToConstant: CGFloat.greatestFiniteMagnitude).isActive = true
//            return spacer
//        }()
//        
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.backgroundColor = .gray
//        stackView.distribution = .equalSpacing
//        stackView.alignment = .fill
//        stackView.isLayoutMarginsRelativeArrangement = true
//        stackView.addArrangedSubview(image)
//        stackView.addArrangedSubview(spacer)
//        return stackView
//    }
//    
//    func addNavigationBar() -> Self {
//        let navigationBar = makeNavigationBar()
//        navigationItem.titleView = navigationBar
//        return self
//    }
//}
//
//extension ProfileCotroller {
//    static func instatntiate(storyBoardName: String) -> Self {
//        let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
//        return storyBoard.instantiateViewController(withIdentifier: String(describing: self)) as! Self
//    }
//}

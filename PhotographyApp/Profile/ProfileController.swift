//
//  ProfileCotroller.swift
//  PhotographyApp
//
//  Created by Elsever on 16.03.25.
//

import UIKit

class ProfileController: UIViewController {

    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewModel.createLayaout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.register(ProfileCell.self, forCellWithReuseIdentifier: "ProfileCell")
        collection.register(ProfileSelectionCell.self, forCellWithReuseIdentifier: "ProfileSelectionCell")
        collection.register(ProfileCollectionCell.self, forCellWithReuseIdentifier: "ProfileCollectionCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    let viewModel = ProfileViewModel()
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        view.addSubview(collection)
        view.backgroundColor = .myBackground
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
            return cell
        case .selection:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "ProfileSelectionCell", for: indexPath) as! ProfileSelectionCell
            cell.callback = { tag in
                self.index = tag
                self.collection.reloadData()
            }
            return cell
        case .collection:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionCell", for: indexPath) as! ProfileCollectionCell
            cell.configure(tag: index)
            cell.backgroundColor = .red
            return cell
        }
      
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
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

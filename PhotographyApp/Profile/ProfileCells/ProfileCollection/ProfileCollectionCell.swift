//
//  ProfileCollectionCell.swift
//  PhotographyApp
//
//  Created by Elsever on 24.03.25.
//

import UIKit

class ProfileCollectionCell: UICollectionViewCell {
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: ProfileCollectionLayout.profileCell())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.register(ProfileCollectionPhotosCell.self, forCellWithReuseIdentifier: "ProfileCollectionPhotosCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    let viewModel = ProfileCollectionViewModel()
    var callback: (() -> Void)?
    
    var index: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  configureUI() {
        addSubview(collection)
    
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configure(tag: Int) {
        index = tag
        collection.reloadData()
    }
}

extension ProfileCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.selections[index ?? 0] {
        case .photos:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionPhotosCell", for: indexPath) as! ProfileCollectionPhotosCell
            cell.backgroundColor = .green
            return cell
        case .likes:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionPhotosCell", for: indexPath) as! ProfileCollectionPhotosCell
            cell.backgroundColor = .blue
            return cell
        case .collections:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionPhotosCell", for: indexPath) as! ProfileCollectionPhotosCell
            cell.backgroundColor = .yellow
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if targetContentOffset.pointee.y == 0 {
            callback?()
//            collection.isScrollEnabled = false
        }
    }
}

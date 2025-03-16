//
//  UploadController.swift
//  PhotographyApp
//
//  Created by Elsever on 16.03.25.
//

import UIKit

class UploadController: UIViewController {

    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: modelView.createLayaout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.register(UploadCell.self, forCellWithReuseIdentifier: "UploadCell")
        collection.register(TextCell.self, forCellWithReuseIdentifier: "TextCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = false
        return collection
    }()
    
    let modelView = UploadViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        view.backgroundColor = .black
        view.addSubview(collection)
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension UploadController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        modelView.numOfCells(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch modelView.sections[indexPath.section] {
        case .image:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "UploadCell", for: indexPath) as! UploadCell
            return cell
        case .text:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as! TextCell
            return cell
        }
       
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
}

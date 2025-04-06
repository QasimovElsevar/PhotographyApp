//
//  PhotoSubmitController.swift
//  PhotographyApp
//
//  Created by Elsever on 03.04.25.
//

import UIKit

class PhotoSubmitController: UIViewController {

    //MARK: -UI Elements
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewModel.createLayaout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.register(TextCell.self, forCellWithReuseIdentifier: "TextCell")
        collection.register(TextFieldCell.self, forCellWithReuseIdentifier: "TextFieldCell")
        collection.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    //MARK: - Properties
    let viewModel = PhotoSubmitViewModel()
    
    //MARK: - Lifcycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .clear
        view.addSubview(collection)
        
        NSLayoutConstraint.activate([
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PhotoSubmitController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section] {
        case .selectedPhotos:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
            return cell
            
        case .descriptionText:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as! TextCell
            cell.configure(text: "Description", textSize: 16)
            collectionView.collectionViewLayout.invalidateLayout()
            return cell
            
        case .locationText:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as! TextCell
            cell.configure(text: "Location", textSize: 16)
            return cell
            
        case .tagsText:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as! TextCell
            cell.configure(text: "Tags", textSize: 16)
            return cell
            
        case .description:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.configure(placeholder: "Add Description")
            cell.callback = {
                self.collection.collectionViewLayout.invalidateLayout()
                self.view.layoutIfNeeded()
            }
            return cell
            
        case .location:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.configure(placeholder: "Add Location")
            return cell
        case .tags:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.configure(placeholder: "Add Tags")
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
}

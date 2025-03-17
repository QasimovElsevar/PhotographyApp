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
        collection.register(TopicsCell.self, forCellWithReuseIdentifier: "TopicsCell")
        collection.register(LatestBlogCell.self, forCellWithReuseIdentifier: "LatestBlogCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    let modelView = UploadViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
//        modelView.getData()
    }
    
    func configure() {
        view.backgroundColor = .myBackground
        view.addSubview(collection)
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureNav() {
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithOpaqueBackground()
        
        if #available(iOS 15.0, *) {
            UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
        }
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
        case .topicText:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as! TextCell
            cell.configure(text: "Submit to topics")
            return cell
        case .topics:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TopicsCell", for: indexPath) as! TopicsCell
            return cell
        case .blog:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "LatestBlogCell", for: indexPath) as! LatestBlogCell
            return cell
        case .blogText:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as! TextCell
            cell.configure(text: "Latest from the blog")
            return cell
        }
       
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        5
    }
}

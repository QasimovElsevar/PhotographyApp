//
//  SearchController.swift
//  PhotographyApp
//
//  Created by Elsever on 26.03.25.
//

import UIKit

class SearchController: UIViewController {
    
    //  MARK: -UI Elements

    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewModel.createLayaout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.register(TextCell.self, forCellWithReuseIdentifier: "TextCell")
        collection.register(TopicsCell.self, forCellWithReuseIdentifier: "TopicsCell")
        collection.register(DoubleHorizontalCell.self, forCellWithReuseIdentifier: "DoubleHorizontalCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var search : UISearchBar = {
        let search = UISearchBar()
        search.backgroundColor = .myBackground
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    //MARK: - Properties

    let viewModel = SearchViewModel()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        FireBaseManager.shared.printCurrentUser()
    }
    
    //  MARK: - UI Configuration
    
    private func configureUI() {
        view.backgroundColor = .myBackground
        addSubviews()
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            search.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            search.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            search.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collection.topAnchor.constraint(equalTo: search.bottomAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addSubviews() {
        view.addSubview(collection)
        view.addSubview(search)
    }
}

extension SearchController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfSections(index: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section] {
        case .browseText:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as! TextCell
            cell.configure(text: "Browse by Category", textSize: 20)
            return cell
        case .browse:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopicsCell", for: indexPath) as! TopicsCell
            return cell
        case .discoverText:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as! TextCell
            cell.configure(text: "Discover", textSize: 20)
            return cell
        case .discover:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DoubleHorizontalCell", for: indexPath) as! DoubleHorizontalCell
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
}

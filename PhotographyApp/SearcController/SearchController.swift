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
        search.target(forAction: #selector(searchPhoto), withSender: nil)
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    //MARK: - Properties

    let viewModel = SearchViewModel()
    let searchController = UISearchController()
   
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        configureUI()
        FireBaseManager.shared.printCurrentUser()
    }
    
    //  MARK: - UI Configuration
    
    private func configureUI() {
        view.backgroundColor = .myBackground
        tabBarController?.navigationItem.searchController = searchController
        addSubviews()
        setConstraints()
        configureTabBar()
        bindViewModel()
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
    
    private func configureTabBar() {
        tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
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
            cell.configure(data: viewModel.searchArray?[indexPath.row].urls?.regular ?? "")
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
}

extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        
        print(text)
    }
    
    
}
extension SearchController {
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
    
    @objc private func searchPhoto() async {
        await viewModel.search(query: search.text ?? "")
    }
}

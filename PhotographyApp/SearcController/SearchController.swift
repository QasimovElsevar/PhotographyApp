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
    
//    private lazy var search : UISearchBar = {
//        let search = UISearchBar()
//        search.backgroundColor = .myBackground
//        search.target(forAction: #selector(searchPhoto), withSender: nil)
//        search.translatesAutoresizingMaskIntoConstraints = false
//        return search
//    }()
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: SearchResultsController())
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.showsSearchResultsController = true
        return search
    }()
    
    //MARK: - Properties

    let viewModel = SearchViewModel()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getData()
    }
    
    //  MARK: - UI Configuration
    
    private func configureUI() {
        view.backgroundColor = .myBackground
        tabBarController?.navigationItem.searchController = searchController
        addSubviews()
        setConstraints()
//        configureTabBar()
        bindViewModel()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
//            search.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            search.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            search.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addSubviews() {
        view.addSubview(collection)
//        view.addSubview(search)
    }
    
    private func configureTabBar() {
        tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
    }
}

extension SearchController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Collection
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
            cell.configure(data: viewModel.photoList[indexPath.row].urls?.regular ?? "", text: viewModel.photoList[indexPath.row].user?.name ?? "")
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 3 && indexPath.row == (viewModel.photoList.count ?? 0) - 1 {
            Task {
               await viewModel.getList()
            }
        }
    }
}

extension SearchController: UISearchResultsUpdating, UISearchBarDelegate {
    
    //MARK: - SearchBar
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else {return}
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchController.searchBar.text else {return}
        searchController.isActive = false
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
    
    func getData() {
        Task {
            await viewModel.getList()
        }
    }
}

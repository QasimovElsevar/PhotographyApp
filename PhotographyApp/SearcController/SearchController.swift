//
//  SearchController.swift
//  PhotographyApp
//
//  Created by Elsever on 26.03.25.
//

import UIKit

final class SearchController: UIViewController {
    
    //  MARK: -UI Elements
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewModel.createLayaout())
        collection.delegate = self
        collection.dataSource = self
        collection.allowsSelection = true
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.register(TextCell.self, forCellWithReuseIdentifier: "TextCell")
        collection.register(TopicsCell.self, forCellWithReuseIdentifier: "TopicsCell")
        collection.register(ImageWithLabelCell.self, forCellWithReuseIdentifier: "ImageWithLabelCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    let resultController = SearchResultsController()

    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: resultController)
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.hidesNavigationBarDuringPresentation = false
        search.obscuresBackgroundDuringPresentation = false
        return search
    }()
    
    //MARK: - Properties
    
    let viewModel = SearchViewModel()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //  MARK: - UI Configuration
    
    private func configureUI() {
        
        view.backgroundColor = .myBackground
        setConstraints()
        configureNavBar()
        bindViewModel()
        statusBarConfigure()
        handeSelectedSuggestion()
    }
    
    private func setConstraints() {
        view.addSubview(collection)
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureNavBar() {
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.isActive = true
        navigationItem.searchController?.searchBar.becomeFirstResponder()
    }
    
    func statusBarConfigure() {
        view.createStatusBarCover(mainView: view)
        view.makeNavBarTransparent(navController: navigationController ?? UINavigationController())
        edgesForExtendedLayout = [.top]
    }
}

extension SearchController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Collection
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
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
            cell.configure(url: viewModel.categories[indexPath.row], topic: viewModel.categories[indexPath.row])
            return cell
        case .discoverText:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as! TextCell
            cell.configure(text: "Discover", textSize: 20)
            return cell
        case .discover:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageWithLabelCell", for: indexPath) as! ImageWithLabelCell
            let list = viewModel.searchArray[indexPath.row]
            cell.configure(data: list.urls?.regular ?? "", text: list.user?.name ?? "", blurHash: list.blurHash ?? "")
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.searchResult?.totalPages ?? 0 > viewModel.page && indexPath.row == viewModel.searchArray.count - 1 && indexPath.section == 3 {
            Task {
                await viewModel.getPages(query: viewModel.query)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            viewModel.query = viewModel.categories[indexPath.row]
            getData(query: viewModel.query)
        } else if indexPath.section == 3 {
            let coordinator = FeedCoordinator(navigationController: navigationController ?? UINavigationController(), id: viewModel.searchArray[indexPath.row].id ?? "")
            coordinator.showImageController()
        }
    }
}

extension SearchController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let query = searchController.searchBar.text, !query.isEmpty {
            resultController.filterSuggestions(isSearched: true, query: query)
        } else {
            resultController.filterSuggestions(isSearched: false)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchController.searchBar.text else {return}
        viewModel.query = query
        getSearch()
    }
}

extension SearchController {
    private func bindViewModel() {
        viewModel.stateUpdate = { [weak self] state in
            
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                switch state {
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
    
    func getSearch() {
        getData(query: viewModel.query)
        searchController.isActive = false
    }
    
    func handeSelectedSuggestion() {
        resultController.selected = { selected in
            self.viewModel.query = selected
            self.searchController.isActive = false
            self.getSearch()
        }

    }
    
    func getData(query: String) {
        Task {
            await viewModel.getList(query: query)
        }
    }
}

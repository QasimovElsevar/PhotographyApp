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
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.register(TextCell.self, forCellWithReuseIdentifier: "TextCell")
        collection.register(TopicsCell.self, forCellWithReuseIdentifier: "TopicsCell")
        collection.register(ImageWithLabelCell.self, forCellWithReuseIdentifier: "ImageWithLabelCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: SearchResultsController())
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.hidesNavigationBarDuringPresentation = false
        search.obscuresBackgroundDuringPresentation = false
        search.searchSuggestions = viewModel.suggestions
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
        addSubviews()
        setConstraints()
        configureNavBar()
        bindViewModel()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addSubviews() {
        view.addSubview(collection)
    }
    
    func configureNavBar() {
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.isActive = true
        navigationItem.searchController?.searchBar.becomeFirstResponder()
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
            cell.configure(topic: viewModel.categories[indexPath.row])
            return cell
        case .discoverText:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextCell", for: indexPath) as! TextCell
            cell.configure(text: "Discover", textSize: 20)
            return cell
        case .discover:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageWithLabelCell", for: indexPath) as! ImageWithLabelCell
            cell.configure(data: viewModel.searchResult?.results?[indexPath.row].urls?.regular ?? "", text: viewModel.searchArray[indexPath.row].user?.name ?? "")
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.searchResult?.totalPages ?? 0 < viewModel.page && indexPath.row == viewModel.searchArray.count - 1 && indexPath.section == 3 {
            getSearch()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            getData(query: viewModel.categories[indexPath.row])
        } else if indexPath.section == 3 {
            let coordinator = MainCoordinator(navigationController: navigationController ?? UINavigationController())
            coordinator.photoId = viewModel.searchArray[indexPath.row].id
            coordinator.showImageController()
        }
    }
}

extension SearchController: UISearchResultsUpdating, UISearchBarDelegate {
    
    //MARK: - SearchBar
    
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""
        if query.isEmpty {
            searchController.searchSuggestions = viewModel.suggestions
        } else {
            searchController.searchSuggestions = viewModel.suggestions.filter {
                $0.localizedSuggestion?.lowercased().contains(query.lowercased()) ?? true
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getSearch()
    }
    
    func searchController(_ searchController: UISearchController, didSelect suggestion: UISearchSuggestion) {
        let selectedText = suggestion.localizedSuggestion
        print("Selected suggestion: \(selectedText)")
        self.searchController.searchBar.text = selectedText
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
        guard let query = searchController.searchBar.text else {return}
        getData(query:query)
        searchController.isActive = false
    }
    
    func getData(query: String) {
        Task {
            await viewModel.getList(query: query)
        }
    }
}

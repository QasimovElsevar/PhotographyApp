//
//  SearchResultsController.swift
//  PhotographyApp
//
//  Created by Elsever on 10.04.25.
//

import UIKit

final class SearchResultsController: UIViewController {
    
    private lazy var table: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.register(TableTextCell.self, forCellReuseIdentifier: "TableTextCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let viewModel = SearchResultViewModel()
    var selected: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    private func configureUI() {
        view.backgroundColor = .myBackground
        configureConstraints()
    }
    
    private func configureConstraints() {
        view.backgroundColor = .settings
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(table)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SearchResultsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isSearched {
            viewModel.filteredSuggestions.count
        } else {
            viewModel.suggestions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.isSearched {
            let cell = table.dequeueReusableCell(withIdentifier: "TableTextCell", for: indexPath) as! TableTextCell
            cell.configure(settingOptions: viewModel.filteredSuggestions[indexPath.row].localizedSuggestion ?? "")
            return cell
        } else {
            let cell = table.dequeueReusableCell(withIdentifier: "TableTextCell", for: indexPath) as! TableTextCell
            cell.configure(settingOptions: viewModel.suggestions[indexPath.row].localizedSuggestion ?? "")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.isSearched {
            selected?( viewModel.filteredSuggestions[indexPath.row].localizedSuggestion ?? "")
        } else {
            selected?( viewModel.suggestions[indexPath.row].localizedSuggestion ?? "")
        }
    }
    
    func updateSerch(isSearched: Bool, query: String?) {
        viewModel.isSearched = isSearched
        print(isSearched)
        table.reloadData()
    }
    
    func filterSuggestions(isSearched: Bool, query: String? = "") {
        viewModel.isSearched = isSearched
        if isSearched {
            viewModel.filteredSuggestions = viewModel.suggestions.filter {
                $0.localizedSuggestion?.lowercased().contains(query?.lowercased() ?? "") ?? false
            }
        }
        table.reloadData()
    }
}

//
//  AddToCollectionControllere.swift
//  PhotographyApp
//
//  Created by Elsever on 26.04.25.
//

import UIKit

final class AddToCollectionController: UIViewController {
    
    private lazy var table: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.register(AddToCollectionControllereCell.self, forCellReuseIdentifier: "AddToCollectionControllereCell")
        tableView.register(TableTextCell.self, forCellReuseIdentifier: "TableTextCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let viewModel: AddToCollectionViewModel
    
    init(viewModel: AddToCollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getCollections()
        bindViewModel()
        navigationController?.navigationItem.title = "Add to Collection"
        navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "new", style: .plain, target: self, action: #selector(handleNew))

    }
    
    private func configureUI() {
        view.addSubview(table)
        view.backgroundColor = .settings
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}

extension AddToCollectionController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "AddToCollectionControllereCell", for: indexPath) as! AddToCollectionControllereCell
        let collection = viewModel.collections[indexPath.row]
        cell.configure(photo: collection.previewPhotos ?? [], title: collection.title ?? "", photoNum: collection.totalPhotos ?? 0)
        cell.callback = {
            print("pushed")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
}

extension AddToCollectionController {
    private func bindViewModel() {
        viewModel.stateUpdate = { [weak self] state in
            
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                switch state {
                case .loading:
//                    loadingView.startAnimating()
                    print("fds")
                case  .loaded:
//                    loadingView.stopAnimating()
                    print("fds")
                case .success:
                    table.reloadData()
                case .error(let error):
                    print(error)
                case .idle:
                    break
                }
                
            }
        }
    }
    
    func getCollections() {
        Task {
            await viewModel.getCollections()
        }
    }
    
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc func handleNew() {
    }
}

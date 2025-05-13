//
//  AddToCollectionControllere.swift
//  PhotographyApp
//
//  Created by Elsever on 26.04.25.
//

import UIKit

final class NewPhotoToCollectionController: UIViewController {
    
    private lazy var table: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(CollectionsCell.self, forCellReuseIdentifier: "CollectionsCell")
        tableView.register(TableTextCell.self, forCellReuseIdentifier: "TableTextCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let viewModel: NewPhotoToCollectionViewModel
    
    init(viewModel: NewPhotoToCollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.getCollections()
        bindViewModel()
    }
    
    private func configureUI() {
        configureNavBar()
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

extension NewPhotoToCollectionController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "CollectionsCell", for: indexPath) as! CollectionsCell
        let collection = viewModel.collections[indexPath.row]
        viewModel.checkCollections(index: indexPath.row)
        cell.configure(photo: collection.photos, title: collection.collectionName ?? "", photoNum: collection.numberOfPhotos ?? 0 , added: viewModel.isAdded)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.checkCollections(index: indexPath.row)
        if !viewModel.isAdded {
            viewModel.addPhotoToCollection(collectionName: viewModel.collections[indexPath.row].collectionName ?? "")
            viewModel.indexOfCollection = indexPath.row
        } else {
            viewModel.deletePhotoFromCollection(collectionName: viewModel.collections[indexPath.row].collectionName ?? "")
            viewModel.indexOfCollection = indexPath.row
        }
    }
}

extension NewPhotoToCollectionController {
    private func bindViewModel() {
        viewModel.stateUpdate = { [weak self] state in
            
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                switch state {
                case .added:
                    viewModel.updateNumberOfPhotos(collectionName: viewModel.collections[viewModel.indexOfCollection].collectionName ?? "", number: viewModel.collections[viewModel.indexOfCollection].photos.count + 1)
                    viewModel.isAdded = true
                    viewModel.getCollections()
                case .deleted:
                    viewModel.updateNumberOfPhotos(collectionName: viewModel.collections[viewModel.indexOfCollection].collectionName ?? "", number: viewModel.collections[viewModel.indexOfCollection].photos.count - 1)
                    viewModel.isAdded = false
                    viewModel.getCollections()
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
    
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc func handleNew() {
        let coordinator = FeedCoordinator(navigationController: navigationController ?? UINavigationController(), photos: viewModel.photo)
        coordinator.callback = {
            self.viewModel.getCollections()
        }
        coordinator.showNewCollectionController()
    }
    
    private func configureNavBar() {
        navigationController?.navigationItem.title = "Add to Collection"
        navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "new", style: .plain, target: self, action: #selector(handleNew))
    }
}

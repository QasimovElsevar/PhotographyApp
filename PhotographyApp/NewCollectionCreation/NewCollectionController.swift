//
//  NewCollectionController.swift
//  PhotographyApp
//
//  Created by Elsever on 07.05.25.
//

import UIKit

class NewCollectionController: UIViewController {
    
    private lazy var fieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .selectionView
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var collectionNameField: UITextField = {
        let textField = UITextField()
        textField.text = "nameField"
        textField.backgroundColor = .selectionView
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var descroptionField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .selectionView
        textField.text = "nameField"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let viewModel = NewCollectionControllerViewModel()
    
    //MARK: - Lyfcycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - UI Configuration
    
    private func configureUI() {
        configureConstraints()
        configureNavBar()
        bindViewModel()
    }
    
    private func configureConstraints() {
        view.backgroundColor = .settings
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(fieldView)
        [collectionNameField,
         descroptionField,
         ].forEach({ fieldView.addSubview($0) })
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            fieldView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            fieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            fieldView.heightAnchor.constraint(equalToConstant: 100 ),
            
            collectionNameField.topAnchor.constraint(equalTo: fieldView.topAnchor, constant: 12),
            collectionNameField.leadingAnchor.constraint(equalTo: fieldView.leadingAnchor, constant: 8),
            collectionNameField.trailingAnchor.constraint(equalTo: fieldView.trailingAnchor, constant: -4),
            
            descroptionField.topAnchor.constraint(equalTo: collectionNameField.bottomAnchor, constant: 12),
            descroptionField.leadingAnchor.constraint(equalTo: fieldView.leadingAnchor, constant: 8),
            descroptionField.trailingAnchor.constraint(equalTo: fieldView.trailingAnchor, constant: -4),
            descroptionField.heightAnchor.constraint(equalToConstant: 50),
        
        ])
    }
    
    private func configureNavBar() {
        navigationController?.navigationItem.title = "Edit collection"
        navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    @objc private func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc private func handleSave() {
        if let collectionName = collectionNameField.text, !collectionName.isEmpty {
            viewModel.createCollection(collectionName: collectionName)
        } else {
            showAllert(title: "Error", message: "Collection name can not be empty")
        }
    }
    
    private func bindViewModel() {
        viewModel.stateUpdate = { [weak self] state in
            
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                switch state {
                case .success:
                    showAllert(title: "Succees", message: "CollectionCreated") { _ in
                        self.dismiss(animated: true)
                    }
                case .error(let error):
                    showAllert(title: "Falied", message: error)
                case .idle:
                    break
                }
                
            }
        }
    }
}

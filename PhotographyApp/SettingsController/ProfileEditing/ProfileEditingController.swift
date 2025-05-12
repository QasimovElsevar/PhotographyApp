//
//  ProfileEditingController.swift
//  PhotographyApp
//
//  Created by Elsever on 22.04.25.
//

import UIKit

final class ProfileEditingController: UIViewController {
    
    //MARK: - UI Elements
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var fieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .selectionView
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameField: UITextField = {
        let textField = UITextField()
        textField.text = "nameField"
        textField.backgroundColor = .selectionView
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var lastnameField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .selectionView
        textField.text = "nameField"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var usernameField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .selectionView
        textField.text = "nameField"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var emailField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .selectionView
        textField.text = "nameField"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let viewModel: ProfileEditingViewModel
    
    init(viewModel: ProfileEditingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lyfcycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTextFields()
    }
    
    //MARK: - UI Configuration
    
    private func configureUI() {
        configureConstraints()
    }
    
    private func configureConstraints() {
        view.backgroundColor = .settings
        addSubviews()
        setConstraints()
        configureNavigationBar()
    }
    
    private func addSubviews() {
        view.addSubview(label)
        view.addSubview(fieldView)
        [nameField,
         lastnameField,
         usernameField,
         emailField].forEach({ fieldView.addSubview($0) })
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            fieldView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            fieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            fieldView.heightAnchor.constraint(equalToConstant: 150 ),
            
            nameField.topAnchor.constraint(equalTo: fieldView.topAnchor, constant: 12),
            nameField.leadingAnchor.constraint(equalTo: fieldView.leadingAnchor, constant: 8),
            nameField.trailingAnchor.constraint(equalTo: fieldView.trailingAnchor, constant: -4),
            
            lastnameField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 12),
            lastnameField.leadingAnchor.constraint(equalTo: fieldView.leadingAnchor, constant: 8),
            lastnameField.trailingAnchor.constraint(equalTo: fieldView.trailingAnchor, constant: -4),
            
            usernameField.topAnchor.constraint(equalTo: lastnameField.bottomAnchor, constant: 12),
            usernameField.leadingAnchor.constraint(equalTo: fieldView.leadingAnchor, constant: 8),
            usernameField.trailingAnchor.constraint(equalTo: fieldView.trailingAnchor, constant: -4),
            
            emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 12),
            emailField.leadingAnchor.constraint(equalTo: fieldView.leadingAnchor, constant: 8),
            emailField.trailingAnchor.constraint(equalTo: fieldView.trailingAnchor, constant: -4),
        ])
    }
    
    private func configureNavigationBar() {
        title = "Settings"
        navigationController?.navigationBar.backgroundColor = .settings
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),style: .plain, target: self, action: #selector(closeSettings))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveChanges))
    }
    
    func configureTextFields() {
        nameField.text = viewModel.userArray.firstname
        lastnameField.text = viewModel.userArray.lastname
        usernameField.text = viewModel.userArray.username
        emailField.text = viewModel.userArray.email
    }
}

extension ProfileEditingController {
    @objc private func closeSettings() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveChanges() {
//        FirestoreManager.shared.updateUserData(firstName: nameField.text ?? "", lastName: lastnameField.text ?? "", username: usernameField.text ?? "", email: emailField.text ?? "", accessKey: viewModel.userArray.accessKey ?? "") { error in
//            if let error = error {
//                print(error)
//            } else {
//                self.showAllert(title: "Success", message: "Your profile updated")
//            }
//        }
    }
}

//
//  AccountController.swift
//  PhotographyApp
//
//  Created by Elsever on 24.04.25.
//

import UIKit

final class AccountController: UIViewController {

    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "Warning"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var warningText: UILabel = {
        let textView = UILabel()
        textView.text = "Clossing your account is irreversible. It deletes all of your photos, collections, and stats."
        textView.font = .systemFont(ofSize: 12, weight: .medium)
        textView.numberOfLines = 0
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close Accouunt", for: .normal)
        button.backgroundColor = .selectionView
        button.tintColor = .red
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .settings

        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        [warningLabel,
         warningText,
         deleteButton
         ].forEach({view.addSubview($0)})
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            warningLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            warningLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            warningLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            warningText.topAnchor.constraint(equalTo: warningLabel.bottomAnchor, constant: 4),
            warningText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            warningText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            deleteButton.topAnchor.constraint(equalTo: warningText.bottomAnchor, constant: 32),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            deleteButton.heightAnchor.constraint(equalToConstant: 44),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}

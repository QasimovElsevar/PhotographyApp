//
//  RegisterController.swift
//  PhotographyApp
//
//  Created by Elsever on 16.03.25.
//

import UIKit

class RegisterController: UIViewController {

    private lazy var joinLabel : UILabel = {
        let label = UILabel()
        label.text = "Join Photography App"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var firstNameTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "First name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
        textField.textColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var lastNameTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Last name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
        textField.textColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var usernameTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
        textField.textColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var emailTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
        textField.textColor = .white
        textField.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
        textField.textColor = .white
        textField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var signUpButton : UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.darkLight, for: .normal)
        button.backgroundColor = .label
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var emailErrorLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .light)
        label.textColor = .red
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var passwordErrorLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .light)
        label.textColor = .red
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .myBackground
        navigationItem.titleView?.tintColor = .label
        navigationItem.backBarButtonItem?.tintColor = .label
//        tabBarController?.navigationController?.navigationItem.backBarButtonItem?.title = "Login"
        self.navigationItem.backButtonTitle = "Login"
        
        [joinLabel,
         firstNameTextField,
         lastNameTextField,
         usernameTextField,
         emailTextField,
         passwordTextField,
         signUpButton,
         emailErrorLabel,
         passwordErrorLabel].forEach( { view.addSubview($0) } )
        
        NSLayoutConstraint.activate([
            joinLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            joinLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            joinLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            firstNameTextField.topAnchor.constraint(equalTo: joinLabel.bottomAnchor, constant: 32),
            firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 20),
            lastNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            usernameTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 20),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            emailErrorLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 4),
            emailErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            passwordErrorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 4),
            passwordErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
                        
            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])
    }
    
    @objc func signUpTapped() {
        if let firstname = firstNameTextField.text, let lastname = lastNameTextField.text, let username = usernameTextField.text, let email = emailTextField.text, let _ = passwordTextField.text {
            FireBaseManager.shared.registerUser(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") { [weak self] error in
                guard let self else {return}
                if let error = error {
                    showAllert(message: error)
                } else {
                    let coordinator = WebCoordinator(navigationController: navigationController ?? UINavigationController())
                    coordinator.start()
                    FirestoreManager.shared.saveUser(firstName: firstname, lastName: lastname, username: username, email: email, accessKey: NetworkManager.shared.authCode ?? "") { [weak self] error in
                        guard let self else {return}
                        if let error = error {
                            showAllert(message: error)
                        } else {
                            showAllert(message: "Successfully registered", completion: { UIAlertAction in
                                self.navigationController?.popViewController(animated: true)
                            })
                        }
                    }
                }
            }
        }
    }

    @objc func emailChanged() {
        if let email = emailTextField.text {
            if let errorMassage = viewModel.InvalidMail(email) {
                emailErrorLabel.text = errorMassage
                emailErrorLabel.isHidden = false
            } else {
                emailErrorLabel.isHidden = true
            }
        }
        check()
    }
    
    @objc func passwordChanged() {
        if let password = passwordTextField.text {
            if let errorMassage = viewModel.InvalidPassword(password) {
                passwordErrorLabel.text = errorMassage
                passwordErrorLabel.isHidden = false
            } else {
                passwordErrorLabel.isHidden = true
            }
        }
        check()
    }
    
    func check() {
        if  passwordErrorLabel.isHidden && emailErrorLabel.isHidden  {
            signUpButton.isEnabled = true
        } else {
            signUpButton.isEnabled = false
        }
    }
}

//
//  RegisterController.swift
//  PhotographyApp
//
//  Created by Elsever on 16.03.25.
//

import UIKit

final class RegisterController: UIViewController {

    // MARK: - UI Elements
        
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
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var lastNameTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Last name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
        textField.textColor = .white
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var usernameTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
        textField.textColor = .white
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var emailTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
        textField.textColor = .white
        textField.autocapitalizationType = .none
        textField.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
        textField.textColor = .white
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
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
    
    //MARK: - Properties
    
    let viewModel = RegisterViewModel()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        notify()
    }

    //MARK: - UI Configuration
    
    func configureUI() {
        view.backgroundColor = .myBackground
        addSubviews()
        setConstraints()
        navBarSetup()
        statusBarConfigure()
    }
    
    private func addSubviews() {
        [joinLabel,
         firstNameTextField,
         lastNameTextField,
         usernameTextField,
         emailTextField,
         passwordTextField,
         signUpButton,
         emailErrorLabel,
         passwordErrorLabel].forEach( { view.addSubview($0) } )
    }
    
    private func setConstraints() {
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
    
    private func navBarSetup() {
        navigationItem.titleView?.tintColor = .label
        navigationItem.backBarButtonItem?.tintColor = .label
        tabBarController?.navigationController?.navigationItem.backBarButtonItem?.title = "Login"
    }
    
    func statusBarConfigure() {
        view.createStatusBarCover(mainView: view)
        view.makeNavBarTransparent(navController: navigationController ?? UINavigationController())
        edgesForExtendedLayout = [.top]
    }
    
    //MARK: - UI Actions
    
    @objc func signUpTapped() {
        if let firstname = firstNameTextField.text, let lastname = lastNameTextField.text, let username = usernameTextField.text, let email = emailTextField.text, let password = passwordTextField.text {
            viewModel.builder.set(firstname: firstname)
            viewModel.builder.set(lastname: lastname)
            viewModel.builder.set(username: username)
            viewModel.builder.set(email: email)
            
            FireBaseManager.shared.registerUser(email: email, password: password) { [weak self] error in
                guard let self else {return}
                if let error = error {
                    showAllert(message: error)
                } else {
                    let coordinator = WebCoordinator(navigationController: navigationController ?? UINavigationController(), viewModel: .init(builder: viewModel.builder))
                    coordinator.start()
                }
            }
        }
    }

    //MARK: - TextField Configurations
    
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
}

extension RegisterController {
    
    func check() {
        if  passwordErrorLabel.isHidden &&
                emailErrorLabel.isHidden &&
                firstNameTextField.text?.isEmpty == false &&
                lastNameTextField.text?.isEmpty == false &&
                lastNameTextField.text?.isEmpty == false
        {
            signUpButton.isEnabled = true
        } else {
            signUpButton.isEnabled = false
        }
    }
    
    func notify() {
        NotificationCenter.default.addObserver(self, selector: #selector(completeRegister), name: NSNotification.Name("webViewDismissed"), object: nil)
    }
    
    @objc func completeRegister() {
        viewModel.sendForAccessToken(completion: { [weak self] response, error in
            if let error = error {
                print(error)
            } else {
                self?.viewModel.builder.set(authToken: response?.accessToken ?? "")
                print(response?.accessToken ?? "")
                
                self?.viewModel.saveData { [weak self] error in
                    if let error = error {
                        print(error)
                    } else {
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            }
        })
    }
}

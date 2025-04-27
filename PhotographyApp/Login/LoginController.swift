//
//  LoginController.swift
//  PhotographyApp
//
//  Created by Elsever on 13.03.25.
//

import UIKit

final class LoginController: UIViewController {
    
    //MARK: - UI Elements
    
    private lazy var loginLabel : UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var accountLabel : UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
        textField.textColor = .white
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.textColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.darkLight, for: .normal)
        button.backgroundColor = .label
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var forgotPasswordButton : UIButton = {
        let button = UIButton()
        button.setTitle("Forgot your password?", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .none
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var joinButton : UIButton = {
        let button = UIButton()
        button.setTitle("Join", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .none
        button.addTarget(self, action: #selector(registerJoin), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stack : UIStackView = {
        let stack = UIStackView()
        stack.spacing = 2
        stack.axis = .horizontal
//        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.addArrangedSubview(accountLabel)
        stack.addArrangedSubview(joinButton)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var errorLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .light)
        label.textColor = .red
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let viewModel = LoginViewModel()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIConfigure()
    }
    
    //MARK: - UI Configurations
    
    private func UIConfigure() {
        view.backgroundColor = .myBackground
        navBarConfigure()
        addSubviews()
        setConstraints()
        statusBarConfigure()
    }
    
    private func navBarConfigure() {
        tabBarController?.navigationItem.backButtonTitle = "Login"
    }
    
    private func addSubviews() {
        [loginLabel,
         emailTextField,
         passwordTextField,
         loginButton,
         forgotPasswordButton,
         stack,
         errorLabel,].forEach( {view.addSubview($0)} )
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            emailTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 32),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            errorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 4),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            stack.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 20),
//            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
//            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            stack.centerXAnchor.constraint(equalTo: super.view.centerXAnchor)
        ])
    }
    
    func statusBarConfigure() {
        view.createStatusBarCover(mainView: view)
        view.makeNavBarTransparent(navController: navigationController ?? UINavigationController())
        edgesForExtendedLayout = [.top]
    }
    
    //MARK: - UI Actions
    
    @objc func loginButtonTapped() {
        FireBaseManager.shared.signInUser(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") { [weak self] error in
            if let error = error {
                self?.showAllert(message: error)
            } else {
                self?.goToProfile()
            }
        }
    }
    
    @objc func registerJoin() {
        let coordinator = RegisterCoordinator(navigationController: navigationController ?? UINavigationController())
        coordinator.start()
    }
}

extension LoginController {
    func goToProfile() {
        if let tabBarVC = self.tabBarController {
            var viewControllers = tabBarVC.viewControllers
            let tabController = TabBarController()
            
            let profileVC = tabController.createProfile()
            
            UIView.transition(with: tabBarVC.view!,
                              duration: 0.2,
                              options: .transitionCrossDissolve,
                              animations: {
                viewControllers?[3] = profileVC
                
                tabBarVC.viewControllers = viewControllers
                
                tabBarVC.selectedIndex = 3
            })
        }
    }
}

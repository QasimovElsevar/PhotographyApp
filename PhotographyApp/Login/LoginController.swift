//
//  LoginController.swift
//  PhotographyApp
//
//  Created by Elsever on 13.03.25.
//

import UIKit

class LoginController: UIViewController {

    private lazy var loginLabel : UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var accountLabel : UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
        textField.textColor = .systemGray6
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
        textField.textColor = .systemGray6
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
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
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .none
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stack : UIStackView = {
        let stack = UIStackView()
        stack.spacing = 2
        stack.axis = .horizontal
//        stack.distribution = .
        stack.alignment = .center
        stack.addArrangedSubview(accountLabel)
        stack.addArrangedSubview(joinButton)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIConfigure()
//        emailTextField.setUnderLine()
//        passwordTextField.setUnderLine()
    }
    
    private func UIConfigure() {
        view.backgroundColor = .black
        [loginLabel,
         emailTextField,
         passwordTextField,
         loginButton,
         forgotPasswordButton,
         stack
//         joinButton,
         /*accountLabel*/].forEach( {view.addSubview($0)} )
        
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            emailTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 32),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
//            accountLabel.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 20),
//            accountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
//            
//            joinButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 20),
//            joinButton.leadingAnchor.constraint(equalTo: accountLabel.trailingAnchor, constant: -4)
////
            stack.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
//            stack.heightAnchor.constraint(equalToConstant: 30),
//            stack.widthAnchor.constraint(equalToConstant: 250),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor)

            
        ])
    }

}

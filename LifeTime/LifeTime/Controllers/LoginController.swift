//
//  LoginController.swift
//  LifeTime
//
//  Created by Дария Григорьева on 31.07.2023.
//

import UIKit

class LoginController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome To LifeTime"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .systemPurple
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemPurple
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.textColor = .white
        textField.borderStyle = .roundedRect
        textField.placeholder = "Email"
        textField.layer.cornerRadius = 10
        textField.setLeftPaddingPoints(20)
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemPurple
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.textColor = .white
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.layer.cornerRadius = 10
        textField.setLeftPaddingPoints(20)
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "login")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "New around here?"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    private let createStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPurple
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var createAnAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create An Account", for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .light)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(createAnAccount), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubviews(titleLabel,
                         emailTextField,
                         passwordTextField,
                         imageView,
                         loginButton,
                         createStackView)
        createStackView.addArrangedSubviews(questionLabel, createAnAccountButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 150),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            createStackView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 12),
            createStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            createStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])
    }
    
    @objc private func createAnAccount() {
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc private func logInButtonTapped() {
        let loginRequest = LoginUser(email: emailTextField.text ?? "",
                                            password: passwordTextField.text ?? "")

        // Email check
        if !ValidationControl.isValidEmail(for: loginRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }

        // Password check
        if !ValidationControl.isPasswordValid(for: loginRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }

        RegisterModel.shared.signIn(with: loginRequest) { error in
            if let error = error {
                AlertManager.showSignInErrorAlert(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
}


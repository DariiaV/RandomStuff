//
//  RegisterViewController.swift
//  LifeTime
//
//  Created by Дария Григорьева on 01.08.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create your account"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .systemPurple
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .systemPurple
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .systemPurple
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .systemPurple
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemPurple
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.textColor = .white
        textField.borderStyle = .roundedRect
        textField.placeholder = "Name"
        textField.layer.cornerRadius = 10
        textField.setLeftPaddingPoints(20)
        textField.autocorrectionType = .no
        return textField
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
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPurple
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "create")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubviews(titleLabel,
                         nameLabel,
                         emailLabel,
                         passwordLabel,
                         nameTextField,
                         emailTextField,
                         passwordTextField,
                         imageView,
                         createAccountButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            emailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 12),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            passwordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            createAccountButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])
    }
    
    @objc private func createAccountButtonTapped() {
        let registerUser = RegisterUser(username: nameTextField.text ?? "",
                                        email: emailTextField.text ?? "",
                                        password: passwordTextField.text ?? "")
        // Username check
        if !ValidationControl.isValidUsername(for: registerUser.username) {
            AlertManager.showInvalidUsernameAlert(on: self)
            return
        }
        
        // Email check
        if !ValidationControl.isValidEmail(for: registerUser.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        // Password check
        if !ValidationControl.isPasswordValid(for: registerUser.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        RegisterModel.shared.registerUser(with: registerUser) { [weak self] wasRegistered, error in
            guard let self = self else { return }
            
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                return
            }
            
            if wasRegistered {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            } else {
                AlertManager.showRegistrationErrorAlert(on: self)
            }
        }
    }
}

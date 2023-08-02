//
//  ProfileViewController.swift
//  LifeTime
//
//  Created by Дария Григорьева on 01.08.2023.
//

import FirebaseAuth
import FirebaseFirestore
import UIKit

class ProfileViewController: UIViewController {
    
    private var user: User?
    
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Profile"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .systemPurple
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .systemPurple
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email:"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .systemPurple
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.textColor = .systemPurple
        return label
    }()
    
    private let userEmailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.textColor = .systemPurple
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    private let emailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPurple
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        fetchUser()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubviews(profileLabel, nameStackView, emailStackView, imageView, logOutButton)
        nameStackView.addArrangedSubviews(nameLabel, userNameLabel)
        emailStackView.addArrangedSubviews(emailLabel, userEmailLabel)
        
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 25),
            profileLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            profileLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            nameStackView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 150),
            nameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            nameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            nameStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameStackView.heightAnchor.constraint(equalToConstant: 50),
            
            emailStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 12),
            emailStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            emailStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            emailStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailStackView.heightAnchor.constraint(equalToConstant: 50),
            
            imageView.topAnchor.constraint(equalTo: logOutButton.bottomAnchor, constant: 12),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            
            logOutButton.topAnchor.constraint(equalTo: emailStackView.bottomAnchor, constant: 20),
            logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
        ])
    }
    
    @objc private func didTapLogout() {
        RegisterModel.shared.signOut { [weak self] error in
            guard let self else { return }
            if let error = error {
                AlertManager.showLogoutError(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.userNameLabel.text = data["username"] as? String ?? ""
                self?.userEmailLabel.text = data["email"] as? String ?? ""
            }
        }
    }
}

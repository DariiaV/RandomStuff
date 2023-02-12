//
//  StartViewController.swift
//  TicTacToe
//
//  Created by Дария Григорьева on 11.02.2023.
//

import UIKit

class StartViewController: UIViewController {
    
    private let backgroundView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "background")
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Marker Felt Thin", size: 41)
        label.textColor = .black
        label.text = "Tic-Tac-Toe"
        return label
    }()
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "cardColor")
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.4
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = .zero
        return view
    }()
    
    private let enterYourNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Enter your name:"
        return label
    }()
    
    private let nameField: UITextField = {
        var textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.textColor = .black
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.setLeftPaddingPoints(20)
        textField.autocorrectionType = .no
        textField.font = .systemFont(ofSize: 16, weight: .medium)
        return textField
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "startButton")
        button.setTitle("Start", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
    }
    
    private func setUpViews() {
        view.addSubviews(backgroundView, nameLabel, cardView)
        cardView.addSubviews(enterYourNameLabel, nameField, startButton)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.widthAnchor.constraint(equalToConstant: 300),
            cardView.heightAnchor.constraint(equalToConstant: 227),
            
            enterYourNameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 30),
            enterYourNameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            enterYourNameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            
            nameField.topAnchor.constraint(equalTo: enterYourNameLabel.bottomAnchor, constant: 20),
            nameField.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            nameField.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            nameField.heightAnchor.constraint(equalToConstant: 50),
            
            startButton.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            startButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            startButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            startButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -30)
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameField.resignFirstResponder()
    }
    
    @objc private func startGame() {
        if let name = nameField.text?.trimmingCharacters(in: .whitespaces),
           !name.isEmpty {
            let vc = GameViewController()
            vc.name = "\(name):"
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

extension StartViewController: UITextFieldDelegate {
    // MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard range.location == 0 else {
            return true
        }
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
        return newString.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines).location != 0
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

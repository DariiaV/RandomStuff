//
//  SettingViewController.swift
//  TrainingApp
//
//  Created by Дария Григорьева on 16.01.2023.
//

import UIKit

class SettingViewController: UIViewController {
    
    private let storageManager = StorageManager.shared
    private var userArray: UserArray?
    private var userModel = UserModel()
    
    private let firstNameLabel = UILabel(text: "   First name")
    private let secondNameLabel = UILabel(text: "   Second name")
    private let heightLabel = UILabel(text: "   Height")
    private let weightLabel = UILabel(text: "   Weight")
    private let targetLabel = UILabel(text: "   Target")
    private lazy var firstNameTextField = createTextField()
    private lazy var secondNameTextField = createTextField()
    private lazy var heightTextField = createTextField()
    private lazy var weightTextField = createTextField()
    private lazy var targetTextField = createTextField()
    private lazy var firstNameStackView = createStackView()
    private lazy var secondNameStackView = createStackView()
    private lazy var heightStackView = createStackView()
    private lazy var weightStackView = createStackView()
    private lazy var targetStackView = createStackView()
    
    
    private let editingProfileLabel: UILabel = {
        let label = UILabel()
        label.text = "EDITING PROFILE"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialGreen
        button.setTitle("SAVE", for: .normal)
        button.titleLabel?.font = .robotoBold16()
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let addPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.7607843137, blue: 0.7607843137, alpha: 1)
        imageView.layer.borderWidth = 5
        imageView.image = UIImage(named: "addPhoto")
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private let addPhotoView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialGreen
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let generalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        addTaps()
        userArray = storageManager.getUserArray()
        loadUserInfo()
    }
    
    override func viewDidLayoutSubviews() {
        addPhotoImageView.layer.cornerRadius = addPhotoImageView.frame.height / 2
    }
    
    private func createTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = .specialBrown
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.textColor = .specialGray
        textField.font = .robotoBold20()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }
    
    private func setupViews() {
        
        view.backgroundColor = .specialBackground
        
        view.addSubviews(editingProfileLabel,
                         closeButton,
                         addPhotoView,
                         addPhotoImageView,
                         generalStackView,
                         saveButton)
        
        firstNameStackView.addArrangedSubviews(firstNameLabel, firstNameTextField)
        secondNameStackView.addArrangedSubviews(secondNameLabel, secondNameTextField)
        heightStackView.addArrangedSubviews(heightLabel, heightTextField)
        weightStackView.addArrangedSubviews(weightLabel, weightTextField)
        targetStackView.addArrangedSubviews(targetLabel, targetTextField)
        generalStackView.addArrangedSubviews(firstNameStackView,
                                             secondNameStackView,
                                             heightStackView,
                                             weightStackView,
                                             targetStackView)
        
        NSLayoutConstraint.activate([
            editingProfileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            editingProfileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.centerYAnchor.constraint(equalTo: editingProfileLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            
            addPhotoImageView.topAnchor.constraint(equalTo: editingProfileLabel.bottomAnchor, constant: 20),
            addPhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            addPhotoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            addPhotoView.topAnchor.constraint(equalTo: addPhotoImageView.topAnchor, constant: 50),
            addPhotoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addPhotoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addPhotoView.heightAnchor.constraint(equalToConstant: 70),
            
            firstNameTextField.heightAnchor.constraint(equalToConstant: 40),
            secondNameTextField.heightAnchor.constraint(equalToConstant: 40),
            heightTextField.heightAnchor.constraint(equalToConstant: 40),
            weightTextField.heightAnchor.constraint(equalToConstant: 40),
            targetTextField.heightAnchor.constraint(equalToConstant: 40),
            
            generalStackView.topAnchor.constraint(equalTo: addPhotoView.bottomAnchor, constant: 20),
            generalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            generalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            saveButton.topAnchor.constraint(equalTo: generalStackView.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            saveButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveButtonTapped() {
        setUserModel()
        guard let userArray = userArray else {
            return
        }
        if userArray.isEmpty {
            storageManager.saveUserModel(model: userModel)
        } else {
            storageManager.updateUserModel(model: userModel)
            
        }
        userModel = UserModel()
    }
    
    private func loadUserInfo() {
        guard let userArray = userArray else {
            return
        }
        if !userArray.isEmpty {
            firstNameTextField.text = userArray[0].userFirstName
            secondNameTextField.text = userArray[0].userSecondName
            heightTextField.text = "\(userArray[0].userHeight)"
            weightTextField.text = "\(userArray[0].userWeight)"
            targetTextField.text = "\(userArray[0].userTarget)"
            
            guard let data = userArray[0].userImage else { return }
            guard let image = UIImage(data: data) else { return }
            addPhotoImageView.image = image
            addPhotoImageView.contentMode = .scaleAspectFit
        }
    }
    
    private func setUserModel() {
        
        guard let firstName = firstNameTextField.text,
              let secondName = secondNameTextField.text,
              let height = heightTextField.text,
              let weight = weightTextField.text,
              let target = targetTextField.text else {
            return
        }
        
        guard let intHeight = Int(height),
              let intWeight = Int(weight),
              let intTarget = Int(target) else {
            return
        }
        
        userModel.userFirstName = firstName
        userModel.userSecondName = secondName
        userModel.userHeight = intHeight
        userModel.userWeight = intWeight
        userModel.userTarget = intTarget
        
        if addPhotoImageView.image == UIImage(named: "addPhoto") {
            userModel.userImage = nil
        } else {
            guard let imageData = addPhotoImageView.image?.pngData() else { return }
            userModel.userImage = imageData
        }
    }
    
    private func addTaps() {
        let tapImageView = UITapGestureRecognizer(target: self, action: #selector(setUserPhoto))
        addPhotoImageView.isUserInteractionEnabled = true
        addPhotoImageView.addGestureRecognizer(tapImageView)
    }
    
    @objc private func setUserPhoto() {
        alertPhotoOrCamera { [weak self] source in
            guard let self = self else { return }
            self.chooseImagePicker(source: source)
        }
    }
}

extension SettingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        addPhotoImageView.image = image
        addPhotoImageView.contentMode = .scaleAspectFit
        dismiss(animated: true)
    }
}


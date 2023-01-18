//
//  NewWorkoutViewController.swift
//  TrainingApp
//
//  Created by Дария Григорьева on 12.01.2023.
//

import UIKit

protocol NewWorkoutViewControllerDelegate: AnyObject {
    func didSaveModel()
}

class NewWorkoutViewController: UIViewController {
    
    weak var delegate: NewWorkoutViewControllerDelegate?
    
    private let dateAndRepeatView = DateAndRepeatView()
    private let repsOrTimerView = RepsOrTimerView()
    private let storageManager = StorageManager.shared
    private var workoutModel = WorkoutModel()
    
    private var currentImageTag: Int?
    private let imagesWorkout = [#imageLiteral(resourceName: "workoutTwo"), #imageLiteral(resourceName: "workoutOne"), #imageLiteral(resourceName: "workoutThree"), #imageLiteral(resourceName: "workoutFour")]
    private var workoutButtons = [UIButton]()
    private let nameLabel = UILabel(text: "Name")
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.delaysContentTouches = false
        return scrollView
    }()
    
    private let newWorkoutLabel: UILabel = {
        let label = UILabel()
        label.text = "NEW WORKOUT"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.textAlignment = .center
        return label
    }()
    
    private let nameTextField: UITextField = {
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
        return textField
    }()
    
    private let dateAndRepeatLabel: UILabel = {
        let label = UILabel()
        label.text = "Date and repeat"
        label.font = .robotoMedium14()
        label.textColor = .specialLightBrown
        return label
    }()
    
    private let repsOrTimerLabel: UILabel = {
        let label = UILabel()
        label.text = "Reps or timer"
        label.font = .robotoMedium14()
        label.textColor = .specialLightBrown
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialGreen
        button.setTitle("SAVE", for: .normal)
        button.titleLabel?.font = .robotoBold16()
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let imageButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        setupViews()
        addTaps()
        createImageButtons()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        view.addSubviews(scrollView)
        
        scrollView.addSubviews(newWorkoutLabel,
                               closeButton,
                               nameLabel,
                               nameTextField,
                               dateAndRepeatLabel,
                               dateAndRepeatView,
                               repsOrTimerLabel,
                               repsOrTimerView,
                               saveButton,
                               imageButtonsStackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            newWorkoutLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            newWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.centerYAnchor.constraint(equalTo: newWorkoutLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            
            nameLabel.topAnchor.constraint(equalTo: newWorkoutLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 38),
            
            dateAndRepeatLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            dateAndRepeatLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            dateAndRepeatLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            dateAndRepeatView.topAnchor.constraint(equalTo: dateAndRepeatLabel.bottomAnchor, constant: 3),
            dateAndRepeatView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateAndRepeatView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateAndRepeatView.heightAnchor.constraint(equalToConstant: 94),
            
            repsOrTimerLabel.topAnchor.constraint(equalTo: dateAndRepeatView.bottomAnchor, constant: 20),
            repsOrTimerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            repsOrTimerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            repsOrTimerView.topAnchor.constraint(equalTo: repsOrTimerLabel.bottomAnchor, constant: 3),
            repsOrTimerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repsOrTimerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            repsOrTimerView.heightAnchor.constraint(equalToConstant: 320),
            
            imageButtonsStackView.topAnchor.constraint(equalTo: repsOrTimerView.bottomAnchor, constant: 10),
            imageButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageButtonsStackView.heightAnchor.constraint(equalToConstant: 50),
            
            saveButton.topAnchor.constraint(equalTo: imageButtonsStackView.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 55),
            saveButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
    
    private func createImageButtons() {
        
        
        for (index, image) in imagesWorkout.enumerated() {
            let button = UIButton()
            button.setImage(image, for: .normal)
            button.contentMode = .scaleAspectFit
            workoutButtons.append(button)
            button.backgroundColor = .specialGreen
            button.layer.cornerRadius = 15
            button.tag = index
            button.alpha = 0.5
            button.addTarget(self, action: #selector(workoutButtonTapped(_:)), for: .touchUpInside)
        }
        imageButtonsStackView.addArrangedSubviews(workoutButtons)
    }
    
    @objc private func workoutButtonTapped(_ selector: UIButton) {
        workoutButtons.forEach { $0.alpha = 0.5}
        currentImageTag = selector.tag
        selector.alpha = 1
    }
    
    private func addTaps() {
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapScreen)
        
        let swipeScreen = UISwipeGestureRecognizer(target: self, action: #selector(swipeHideKeyboard))
        swipeScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(swipeScreen)
    }
    
    private func setModel() {
        guard let nameWorkout = nameTextField.text else {
            return
        }
        workoutModel.workoutName = nameWorkout
        
        workoutModel.workoutDate = dateAndRepeatView.datePicker.date.localDate()
        workoutModel.workoutNumberOfDay = dateAndRepeatView.datePicker.date.getWeekdayNumber()
        workoutModel.workoutRepeat = (dateAndRepeatView.repeatSwitch.isOn)
        workoutModel.workoutSets = Int(repsOrTimerView.setsSlider.value)
        workoutModel.workoutReps = Int(repsOrTimerView.repsSlider.value)
        workoutModel.workoutTimer = Int(repsOrTimerView.timerSlider.value)
        
        if let currentImageTag,
           let imageData = imagesWorkout[currentImageTag].pngData() {
            workoutModel.workoutImage = imageData
        }
        
    }
    
    
    private func saveModel() {
        guard let text = nameTextField.text else { return }
        let count = text.filter{ $0.isNumber || $0.isLetter }.count
        
        if count != 0 && workoutModel.workoutSets != 0 && (workoutModel.workoutReps != 0 || workoutModel.workoutTimer != 0) {
            storageManager.saveWorkoutModel(model: workoutModel)
            createNotification()
            alertOk(title: "Success", message: nil)
            refreshWorkoutObjects()
        } else {
            alertOk(title: "Error", message: "Enter all parameters")
        }
    }
    
    private func refreshWorkoutObjects() {
        dateAndRepeatView.datePicker.setDate(Date(), animated: true)
        nameTextField.text = ""
        dateAndRepeatView.repeatSwitch.isOn = true
        repsOrTimerView.numberOfSetLabel.text = "0"
        repsOrTimerView.setsSlider.value = 0
        repsOrTimerView.numberOfRepsLabel.text = "0"
        repsOrTimerView.repsSlider.value = 0
        repsOrTimerView.numberOfTimerLabel.text = "0"
        repsOrTimerView.timerSlider.value = 0
        currentImageTag = nil
        workoutButtons.forEach { $0.alpha = 0.5 }
        workoutModel = WorkoutModel()
    }
    
    private func createNotification() {
        let notifications = Notifications()
        let stringDate = workoutModel.workoutDate.ddMMyyyyFromDate()
        print(workoutModel.workoutDate)
        notifications.scheduleDateNotification(date: workoutModel.workoutDate, id: "workout" + stringDate)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveButtonTapped() {
        setModel()
        saveModel()
        delegate?.didSaveModel()
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func swipeHideKeyboard() {
        view.endEditing(true)
    }
}

extension NewWorkoutViewController: UITextFieldDelegate {
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
    }
}

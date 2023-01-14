//
//  StartWorkoutViewController.swift
//  TrainingApp
//
//  Created by Дария Григорьева on 14.01.2023.
//

import UIKit

protocol StartWorkoutViewControllerDelegate: AnyObject {
    func didTapFinishWorkout()
}

class StartWorkoutViewController: UIViewController {
    
    weak var delegate: StartWorkoutViewControllerDelegate?
    var workoutModel = WorkoutModel()
    
    private let workoutParametersView = WorkoutParametersView()
    private let detailsLabel = UILabel(text: "Details")
    private let storageManager = StorageManager.shared
    
    private let newWorkoutLabel: UILabel = {
        let label = UILabel()
        label.text = "START WORKOUT"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.textAlignment = .center
        return label
    }()
    
    private let sportManImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "stortsMan")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialGreen
        button.layer.cornerRadius = 10
        button.setTitle("FINISH", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .robotoBold16()
        button.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var numberOfSet = 1
    
    override func viewDidLayoutSubviews() {
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setWorkoutParameters()
        workoutParametersView.cellNextSetDelegate = self
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubviews(newWorkoutLabel,
                         newWorkoutLabel,
                         closeButton,
                         sportManImageView,
                         detailsLabel,
                         workoutParametersView,
                         finishButton)
        
        NSLayoutConstraint.activate([
            newWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            newWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.centerYAnchor.constraint(equalTo: newWorkoutLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            
            sportManImageView.topAnchor.constraint(equalTo: newWorkoutLabel.bottomAnchor, constant: 20),
            sportManImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sportManImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            sportManImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            detailsLabel.topAnchor.constraint(equalTo: sportManImageView.bottomAnchor, constant: 20),
            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            detailsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            workoutParametersView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5),
            workoutParametersView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            workoutParametersView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            workoutParametersView.heightAnchor.constraint(equalToConstant: 230),
            
            finishButton.topAnchor.constraint(equalTo: workoutParametersView.bottomAnchor, constant: 20),
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func finishButtonTapped() {
        if numberOfSet == workoutModel.workoutSets {
            dismiss(animated: true)
            storageManager.updateWorkoutModel(model: workoutModel, bool: true)
            delegate?.didTapFinishWorkout()
        } else {
            alertOkCancel(title: "Warning", message: "You haven't finished your workout") {
                self.dismiss(animated: true)
            }
        }
    }
    
    private func setWorkoutParameters() {
        workoutParametersView.setLabelsText(workoutName: workoutModel.workoutName,
                                            numberOfSets: "\(numberOfSet)/\(workoutModel.workoutSets)",
                                            numberOfReps: "\(workoutModel.workoutReps)")
    }
}

extension StartWorkoutViewController: NextSetProtocol {
    // MARK: - NextSetProtocol
    func nextSetTapped() {
        if numberOfSet < workoutModel.workoutSets {
            numberOfSet += 1
            workoutParametersView.setNumberOfSets(text: "\(numberOfSet)/\(workoutModel.workoutSets)")
        } else {
            alertOk(title: "Error", message: "Finish your workout")
        }
    }
}


//
//  WorkoutParametersView.swift
//  TrainingApp
//
//  Created by Дария Григорьева on 14.01.2023.
//

import UIKit

protocol NextSetProtocol: AnyObject {
    func nextSetTapped()
}

class WorkoutParametersView: UIView {
    weak var cellNextSetDelegate: NextSetProtocol?
    
    private let workoutNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .specialGray
        label.font = .robotoMedium24()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let setsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sets"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        return label
    }()
    
    private let numberOfSetsLabel: UILabel = {
        let label = UILabel()
        label.text = "1/4"
        label.textAlignment = .right
        label.textColor = .specialGray
        label.font = .robotoMedium24()
        return label
    }()
    
    private let setsLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLine
        return view
    }()
    
    private let repsLabel: UILabel = {
        let label = UILabel()
        label.text = "Reps"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        return label
    }()
    
    let numberOfRepsLabel: UILabel = {
        let label = UILabel()
        label.text = "20"
        label.textAlignment = .right
        label.textColor = .specialGray
        label.font = .robotoMedium24()
        return label
    }()
    
    private let repsLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLine
        return view
    }()
    
    private lazy var editingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "editing")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitle("Editing", for: .normal)
        button.tintColor = .specialLightBrown
        button.titleLabel?.font = .robotoMedium16()
        button.addTarget(self, action: #selector(editingButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextSetsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialYellow
        button.layer.cornerRadius = 10
        button.setTitle("NEXT SET", for: .normal)
        button.tintColor = .specialGray
        button.titleLabel?.font = .robotoBold16()
        button.addTarget(self, action: #selector(nextSetsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let repsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    private let setsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabelsText(workoutName: String, numberOfSets: String, numberOfReps: String) {
        workoutNameLabel.text = workoutName
        numberOfSetsLabel.text = numberOfSets
        numberOfRepsLabel.text = numberOfReps
    }
    
    func setNumberOfSets(text: String) {
        numberOfSetsLabel.text = text
    }
    
    private func setupViews() {
        backgroundColor = .specialBrown
        layer.cornerRadius = 10
        
        setsStackView.addArrangedSubviews(setsLabel, numberOfSetsLabel)
        repsStackView.addArrangedSubviews(repsLabel, numberOfRepsLabel)
        
        addSubviews(workoutNameLabel,
                    setsStackView,
                    setsLineView,
                    repsStackView,
                    repsLineView,
                    editingButton,
                    nextSetsButton)
        
        NSLayoutConstraint.activate([
            workoutNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            workoutNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            workoutNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            setsStackView.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 10),
            setsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            setsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            setsStackView.heightAnchor.constraint(equalToConstant: 25),
            
            setsLineView.topAnchor.constraint(equalTo: setsStackView.bottomAnchor, constant: 2),
            setsLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            setsLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            setsLineView.heightAnchor.constraint(equalToConstant: 1),
            
            repsStackView.topAnchor.constraint(equalTo: setsLineView.bottomAnchor, constant: 20),
            repsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            repsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            repsStackView.heightAnchor.constraint(equalToConstant: 25),
            
            repsLineView.topAnchor.constraint(equalTo: repsStackView.bottomAnchor, constant: 2),
            repsLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            repsLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            repsLineView.heightAnchor.constraint(equalToConstant: 1),
            
            editingButton.topAnchor.constraint(equalTo: repsLineView.bottomAnchor, constant: 10),
            editingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            editingButton.heightAnchor.constraint(equalToConstant: 20),
            editingButton.widthAnchor.constraint(equalToConstant: 80),
            
            nextSetsButton.topAnchor.constraint(equalTo: editingButton.bottomAnchor, constant: 10),
            nextSetsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextSetsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nextSetsButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    @objc private func editingButtonTapped() {
        print("editingButtonTapped")
    }
    
    @objc private func nextSetsButtonTapped() {
        cellNextSetDelegate?.nextSetTapped()
    }
    
}

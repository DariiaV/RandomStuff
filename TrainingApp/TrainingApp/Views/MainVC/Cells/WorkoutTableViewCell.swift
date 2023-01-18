//
//  WorkoutTableViewCell.swift
//  TrainingApp
//
//  Created by Дария Григорьева on 11.01.2023.
//

import UIKit

protocol WorkoutTableViewCellDelegate: AnyObject {
    func startButtonTapped(model: WorkoutModel)
}

class WorkoutTableViewCell: UITableViewCell {
    
    weak var delegate: WorkoutTableViewCellDelegate?
    var workoutModel = WorkoutModel()
    
    private let backgroundCell: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBrown
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let workoutBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialGreen
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let workoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .specialGreen
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameWorkoutLabel: UILabel = {
        let label = UILabel()
        label.textColor = .specialBlack
        label.font = .robotoMedium22()
        label.textAlignment = .left
        return label
    }()
    
    private let countApproachLabel: UILabel = {
        let label = UILabel()
        label.textColor = .specialGray
        label.font = .robotoMedium16()
        label.textAlignment = .left
        return label
    }()
    
    private lazy var completeButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .robotoBold16()
        button.layer.cornerRadius = 10
        button.addShadowOnView()
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfigure(model: WorkoutModel) {
        nameWorkoutLabel.text = model.workoutName
        
        let (min, sec) = { (secs: Int) -> (Int, Int) in
            return (secs / 60, secs % 60)}(model.workoutTimer)
        
        let reps = (model.workoutTimer == 0 ? "Reps: \(model.workoutReps)" : "Timer: \(min) min \(sec) sec")
        let sets = " Sets: \(model.workoutSets)"
        
        countApproachLabel.text = reps + sets
        
        guard let imageData = model.workoutImage else {
            return
        }
        guard let image = UIImage(data: imageData) else {
            return
        }
        workoutImageView.image = image
        
        if model.status {
            completeButton.setTitle("COMPLETE", for: .normal)
            completeButton.tintColor = .white
            completeButton.backgroundColor = .specialGreen
            completeButton.isEnabled = false
        } else {
            completeButton.setTitle("START", for: .normal)
            completeButton.tintColor = .specialDarkGreen
            completeButton.backgroundColor = .specialYellow
            completeButton.isEnabled = true
        }
        workoutModel = model
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubviews(backgroundCell,
                                completeButton,
                                workoutBackgroundView,
                                nameWorkoutLabel,
                                countApproachLabel)
        
        workoutBackgroundView.addSubviews(workoutImageView)
        
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            workoutBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            workoutBackgroundView.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
            workoutBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            workoutBackgroundView.widthAnchor.constraint(equalTo: workoutBackgroundView.heightAnchor),
            
            workoutImageView.topAnchor.constraint(equalTo: workoutBackgroundView.topAnchor, constant: 10),
            workoutImageView.leadingAnchor.constraint(equalTo: workoutBackgroundView.leadingAnchor, constant: 10),
            workoutImageView.trailingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: -10),
            workoutImageView.bottomAnchor.constraint(equalTo: workoutBackgroundView.bottomAnchor, constant: -10),
            
            nameWorkoutLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameWorkoutLabel.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
            nameWorkoutLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            
            countApproachLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            countApproachLabel.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
            countApproachLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            
            completeButton.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
            completeButton.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            completeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            completeButton.topAnchor.constraint(equalTo: countApproachLabel.bottomAnchor)
        ])
    }
  
    
    @objc private func startButtonTapped() {
        delegate?.startButtonTapped(model: workoutModel)
    }
    
}


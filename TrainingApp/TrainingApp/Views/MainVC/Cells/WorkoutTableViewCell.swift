//
//  WorkoutTableViewCell.swift
//  TrainingApp
//
//  Created by Дария Григорьева on 11.01.2023.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {
    
    private let backgroundCell: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBrown
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let workoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "imageCell")
        imageView.backgroundColor = .specialBackground
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let nameWorkoutLabel: UILabel = {
        let label = UILabel()
        label.text = "Pull Ups"
        label.font = .robotoMedium24()
        label.textAlignment = .left
        return label
    }()
    
    private let countApproachLabel: UILabel = {
        let label = UILabel()
        label.text = "Reps: 10 Sets: 2"
        label.font = .robotoMedium14()
        label.textAlignment = .left
        return label
    }()
    
    private lazy var completeButton: UIButton = {
       let button = UIButton()
        button.setTitle("Complete", for: .normal)
        button.backgroundColor = .specialGreen
        button.tintColor = .white
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubviews(backgroundCell, completeButton, workoutImageView, nameWorkoutLabel, countApproachLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            workoutImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            workoutImageView.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
            workoutImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            workoutImageView.widthAnchor.constraint(equalTo: workoutImageView.heightAnchor),
            
            nameWorkoutLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameWorkoutLabel.leadingAnchor.constraint(equalTo: workoutImageView.trailingAnchor, constant: 10),
            nameWorkoutLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            
            countApproachLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            countApproachLabel.leadingAnchor.constraint(equalTo: workoutImageView.trailingAnchor, constant: 10),
            countApproachLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            
            completeButton.leadingAnchor.constraint(equalTo: workoutImageView.trailingAnchor, constant: 10),
            completeButton.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            completeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            completeButton.topAnchor.constraint(equalTo: countApproachLabel.bottomAnchor)
        
        ])
    }
    
}


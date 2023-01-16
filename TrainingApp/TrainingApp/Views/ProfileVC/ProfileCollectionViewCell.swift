//
//  ProfileCollectionViewCell.swift
//  TrainingApp
//
//  Created by Дария Григорьева on 16.01.2023.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "PUSH UPS"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .robotoBold24()
        return label
    }()
    
    private let workoutImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "1")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "180"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .robotoBold48()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        layer.cornerRadius = 20
        backgroundColor = .specialDarkYellow
        addSubviews(nameLabel, workoutImageView, numberLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        
            workoutImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            workoutImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            workoutImageView.heightAnchor.constraint(equalToConstant: 57),
            workoutImageView.widthAnchor.constraint(equalToConstant: 57),
     
            numberLabel.centerYAnchor.constraint(equalTo: workoutImageView.centerYAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: workoutImageView.trailingAnchor, constant: 10)
        ])
    }
    
    func cellConfigure(model: ResultWorkout) {
        nameLabel.text = model.name
        numberLabel.text = "\(model.result)"
        
        guard let data = model.imageData else {
            return
        }
        let image = UIImage(data: data)
        workoutImageView.image = image
    }
}

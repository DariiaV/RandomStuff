//
//  weatherView.swift
//  TrainingApp
//
//  Created by Дария Григорьева on 11.01.2023.
//

import UIKit

class WeatherView: UIView {
    
    private let weatherStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunny"
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        label.textAlignment = .left
        return label
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Nice weather to work out outside"
        label.font = .robotoMedium14()
        label.textColor = .specialGray
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Group 114")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        backgroundColor = .white
        layer.cornerRadius = 10
        addShadowOnView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubviews(weatherStatusLabel, weatherDescriptionLabel, weatherImageView)
        
        NSLayoutConstraint.activate([
            weatherImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            weatherImageView.heightAnchor.constraint(equalToConstant: 60),
            weatherImageView.widthAnchor.constraint(equalToConstant: 60),
            
            weatherStatusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            weatherStatusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weatherStatusLabel.trailingAnchor.constraint(equalTo: weatherImageView.leadingAnchor, constant: 10),
            weatherStatusLabel.heightAnchor.constraint(equalToConstant: 20),
            
            weatherDescriptionLabel.topAnchor.constraint(equalTo: weatherStatusLabel.bottomAnchor, constant: 0),
            weatherDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weatherDescriptionLabel.trailingAnchor.constraint(equalTo: weatherImageView.leadingAnchor, constant: -10),
            weatherDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
}

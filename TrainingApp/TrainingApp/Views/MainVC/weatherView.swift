//
//  weatherView.swift
//  TrainingApp
//
//  Created by Дария Григорьева on 11.01.2023.
//

import UIKit

class WeatherView: UIView {
    
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunny"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.textAlignment = .left
        return label
    }()
    
    private let invitationLabel: UILabel = {
        let label = UILabel()
        label.text = "Nice weather to work out outside"
        label.font = .robotoMedium14()
        label.textColor = .specialLightBrown
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
        layer.cornerRadius = 20
        addShadowOnView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubviews(weatherLabel, invitationLabel, weatherImageView)
        
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            weatherImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            weatherImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            weatherImageView.heightAnchor.constraint(equalToConstant: 70),
            weatherImageView.widthAnchor.constraint(equalToConstant: 70),
            
            weatherLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            weatherLabel.trailingAnchor.constraint(equalTo: weatherImageView.leadingAnchor, constant: -5),
            weatherLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            invitationLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 10),
            invitationLabel.trailingAnchor.constraint(equalTo: weatherImageView.leadingAnchor,constant: -5),
            invitationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        
        ])
    }
    
}

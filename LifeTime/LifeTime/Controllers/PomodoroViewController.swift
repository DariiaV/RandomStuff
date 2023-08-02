//
//  PomodoroViewController.swift
//  LifeTime
//
//  Created by Дария Григорьева on 01.08.2023.
//

import UIKit

class PomodoroViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Focus on what's important"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .systemPurple
        label.numberOfLines = 2
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "25:00"
        label.textColor = .systemPurple
        label.font = .systemFont(ofSize: 100, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let circleOneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle")
        imageView.tintColor = .systemPurple
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let circleTwoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle")
        imageView.tintColor = .systemPurple
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let circleThreeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle")
        imageView.tintColor = .systemPurple
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let circleFourImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle")
        imageView.tintColor = .systemPurple
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "focus")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let circleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPurple
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        //button.addTarget(self, action: #selector(didTapStart), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubviews(titleLabel,
                         timerLabel,
                         startButton,
                         circleStackView,
                         imageView)
        
        circleStackView.addArrangedSubviews(circleOneImageView,
                                            circleTwoImageView,
                                            circleThreeImageView,
                                            circleFourImageView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            circleStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            circleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            circleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            timerLabel.topAnchor.constraint(equalTo: circleStackView.bottomAnchor, constant: 30),
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            startButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 30),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            imageView.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
}

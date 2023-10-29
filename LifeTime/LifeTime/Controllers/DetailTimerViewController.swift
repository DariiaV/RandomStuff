//
//  DetailTimerViewController.swift
//  LifeTime
//
//  Created by Дария Григорьева on 22.08.2023.
//

import UIKit

class DetailTimerViewController: UIViewController {
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .systemPurple
        label.font = .systemFont(ofSize: 120, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "time")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubviews(timerLabel, imageView)
        
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 150),
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            imageView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 90),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
   
}

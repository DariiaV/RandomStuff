//
//  TimeoutSessionViewController.swift
//  LifeTime
//
//  Created by Дария Григорьева on 10.08.2023.
//

import UIKit

class TimeoutSessionViewController: UIViewController {
    
    private var timer = Timer()
    private var isTimerStarted = false
    private var time = 60
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Now let's relax"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .systemPurple
        label.numberOfLines = 2
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "1:00"
        label.textColor = .systemPurple
        label.font = .systemFont(ofSize: 100, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "timeout")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var startStopButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPurple
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPurple
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
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
                         imageView,
                         startStopButton,
                         resetButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            timerLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 90),
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            startStopButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 30),
            startStopButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            startStopButton.widthAnchor.constraint(equalToConstant: 100),
            
            resetButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 30),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            resetButton.widthAnchor.constraint(equalToConstant: 100),
            
            imageView.topAnchor.constraint(equalTo: startStopButton.bottomAnchor, constant: 70),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    @objc private func startStopButtonTapped() {
        if !isTimerStarted{
            startTimer()
            isTimerStarted = true
            startStopButton.setTitle("Pause", for: .normal)
        } else {
            timer.invalidate()
            isTimerStarted = false
            startStopButton.setTitle("Start", for: .normal)
        }
    }
    
    @objc private func resetButtonTapped() {
        let alert = UIAlertController(title: "Reset Timeout?", message: "Are you sure you would like to reset the Timeout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { _ in
            //do nothing
        }))
        
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { [self] _ in
            timer.invalidate()
            time = 60
            isTimerStarted = false
            timerLabel.text = "1:00"
            startStopButton.setTitle("Start", for: .normal)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func updateTimer() {
        if time > 0 {
            isTimerStarted = true
            time -= 1
            timerLabel.text = formatTime()
        } else if time == 0 {
            isTimerStarted = false
            timer.invalidate()
            dismiss(animated: true)
        }
    }
    
    private func formatTime() -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
}

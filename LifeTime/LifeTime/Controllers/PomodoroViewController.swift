//
//  PomodoroViewController.swift
//  LifeTime
//
//  Created by Дария Григорьева on 01.08.2023.
//

import UIKit

class PomodoroViewController: UIViewController {
    
    private var timer = Timer()
    private var isTimerStarted = false
    private var time = 60
    private var nextFocusBlock: FocusSession = .firstSession
    
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
        label.text = "1:00"
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
                         circleStackView,
                         imageView,
                         startStopButton,
                         resetButton)
        
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
            
            startStopButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 30),
            startStopButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            startStopButton.widthAnchor.constraint(equalToConstant: 100),
            
            resetButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 30),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            resetButton.widthAnchor.constraint(equalToConstant: 100),
            
            imageView.topAnchor.constraint(equalTo: startStopButton.bottomAnchor, constant: 30),
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
        let alert = UIAlertController(title: "Reset Focus?", message: "Are you sure you would like to reset the Focus?", preferredStyle: .alert)
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
            updateCompletedSession(for: nextFocusBlock)
            time = 60
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
    
    private func updateCompletedSession(for nextTimeBlock: FocusSession) {
        
        switch nextTimeBlock {
        case .firstSession:
            timerLabel.text = "1:00"
            startStopButton.setTitle("Start", for: .normal)
            circleOneImageView.image = UIImage(systemName: "circle.fill")
            nextFocusBlock = .secondSession
            
            if time == 0 {
                startTimeoutSession()
            }
            
        case .secondSession:
            timerLabel.text = "1:00"
            startStopButton.setTitle("Start", for: .normal)
            circleTwoImageView.image = UIImage(systemName: "circle.fill")
            nextFocusBlock = .thirdSession
            
            if time == 0 {
                startTimeoutSession()
            }
            
        case .thirdSession:
            timerLabel.text = "1:00"
            startStopButton.setTitle("Start", for: .normal)
            circleThreeImageView.image = UIImage(systemName: "circle.fill")
            nextFocusBlock = .fourthSession
            
            if time == 0 {
                startTimeoutSession()
            }
            
        case .fourthSession:
            timerLabel.text = "1:00"
            startStopButton.setTitle("Start", for: .normal)
            circleFourImageView.image = UIImage(systemName: "circle.fill")
            nextFocusBlock = .firstSession
            
            if time == 0 {
                startNewCycleFocus()
            }
        }
    }
    
    private func resetImageViews() {
        circleOneImageView.image = UIImage(systemName: "circle")
        circleTwoImageView.image = UIImage(systemName: "circle")
        circleThreeImageView.image = UIImage(systemName: "circle")
        circleFourImageView.image = UIImage(systemName: "circle")
    }
    
    private func startNewCycleFocus() {
        let alert = UIAlertController(title: "Reset Focus?", message: "You have finished the focus cycle.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { [self] _ in
            timer.invalidate()
            resetImageViews()
            time = 60
            isTimerStarted = false
            timerLabel.text = "1:00"
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func startTimeoutSession() {
        let timeoutVC = TimeoutSessionViewController()
        timeoutVC.modalPresentationStyle = .fullScreen
        present(timeoutVC, animated: true)
    }
}

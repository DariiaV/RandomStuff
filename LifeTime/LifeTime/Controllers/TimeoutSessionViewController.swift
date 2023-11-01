//
//  TimeoutSessionViewController.swift
//  LifeTime
//
//  Created by Дария Григорьева on 10.08.2023.
//

import UIKit

protocol TimeoutSessionViewControllerDelegate: AnyObject {
    func finishShortBreak()
    func finishLongBreak()
}

final class TimeoutSessionViewController: UIViewController {
    private var timer = Timer()
    private var isTimerStarted = false
    private var time: Int
    
    weak var delegate: TimeoutSessionViewControllerDelegate?
    
    private let signalManager = SignalManager()
    private let session: BreakSession
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Now let's relax"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .systemPurple
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = formatTime()
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
    
    init(session: BreakSession) {
        self.session = session
        switch session {
        case .shortBreak:
            time = .shortBreakTime
        case .longBreak:
            time = .longBreakTime
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            time = time
            isTimerStarted = false
            timerLabel.text = String(time)
            startStopButton.setTitle("Start", for: .normal)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func updateTimer() {
        if time > 0 {
            isTimerStarted = true
            time -= 1
            timerLabel.text = formatTime()
        } else if time == 0 {
            isTimerStarted = false
            timer.invalidate()
            signalManager.playSound()
            goToFocus()
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
    
    private func goToFocus() {
        let alert = UIAlertController(title: "Go To Focus?", message: "You have finished Timeout.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { _ in
            self.dismiss(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

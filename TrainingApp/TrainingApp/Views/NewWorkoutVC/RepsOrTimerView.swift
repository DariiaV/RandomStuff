//
//  RepsOrTimerView.swift
//  TrainingApp
//
//  Created by Дария Григорьева on 12.01.2023.
//

import UIKit

class RepsOrTimerView: UIView {
    
    private let setsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sets"
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        return label
    }()
    
    let numberOfSetLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        return label
    }()
    
    private let repeatOrTimerLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose repeat or timer"
        label.font = .robotoMedium14()
        label.textColor = .specialLightBrown
        return label
    }()
    
    private let repsLabel: UILabel = {
        let label = UILabel()
        label.text = "Reps"
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        return label
    }()
    
    let numberOfRepsLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "Timer"
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        return label
    }()
    
    let numberOfTimerLabel: UILabel = {
        let label = UILabel()
        label.text = "0 min"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        return label
    }()
    
    lazy var timerSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 600
        slider.maximumTrackTintColor = .specialLightBrown
        slider.minimumTrackTintColor = .specialGreen
        slider.addTarget(self, action: #selector(timerSliderChanged), for: .valueChanged)
        return slider
    }()
    
    lazy var setsSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 50
        slider.maximumTrackTintColor = .specialLightBrown
        slider.minimumTrackTintColor = .specialGreen
        slider.addTarget(self, action: #selector(setsSliderChanged), for: .valueChanged)
        return slider
    }()
    
    lazy var repsSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 50
        slider.maximumTrackTintColor = .specialLightBrown
        slider.minimumTrackTintColor = .specialGreen
        slider.addTarget(self, action: #selector(repsSliderChanged), for: .valueChanged)
        return slider
    }()
    
    var setsStackView = UIStackView()
    var repsStackView = UIStackView()
    var timerStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .specialBrown
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        setsStackView = UIStackView(arrangedSubviews: [setsLabel,
                                                       numberOfSetLabel],
                                    axis: .horizontal,
                                    spacing: 10)
        repsStackView = UIStackView(arrangedSubviews: [repsLabel, numberOfRepsLabel],
                                    axis: .horizontal,
                                    spacing: 10)
        timerStackView = UIStackView(arrangedSubviews: [timerLabel, numberOfTimerLabel],
                                     axis: .horizontal,
                                     spacing: 10)
        
        addSubviews(setsStackView,
                    setsSlider,
                    repeatOrTimerLabel,
                    repsStackView,
                    repsSlider,
                    timerStackView,
                    timerSlider)
        
        NSLayoutConstraint.activate([
            setsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            setsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            setsSlider.topAnchor.constraint(equalTo: setsStackView.bottomAnchor, constant: 10),
            setsSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setsSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            repeatOrTimerLabel.topAnchor.constraint(equalTo: setsSlider.bottomAnchor, constant: 15),
            repeatOrTimerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            repsStackView.topAnchor.constraint(equalTo: repeatOrTimerLabel.bottomAnchor, constant: 20),
            repsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            repsSlider.topAnchor.constraint(equalTo: repsStackView.bottomAnchor, constant: 10),
            repsSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            timerStackView.topAnchor.constraint(equalTo: repsSlider.bottomAnchor, constant: 20),
            timerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            timerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            timerSlider.topAnchor.constraint(equalTo: timerStackView.bottomAnchor, constant: 10),
            timerSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            timerSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
    
    private func setActive(label: UILabel, numberLabel: UILabel, slider: UISlider) {
        label.alpha = 1
        numberLabel.alpha = 1
        slider.alpha = 1
    }
    
    private func setNegative(label: UILabel, numberLabel: UILabel, slider: UISlider) {
        label.alpha = 0.5
        numberLabel.alpha = 0.5
        numberLabel.text = "0"
        slider.alpha = 0.5
        slider.value = 0
    }
    
    @objc private func setsSliderChanged() {
        numberOfSetLabel.text = "\(Int(setsSlider.value))"
    }
    
    @objc private func repsSliderChanged() {
        numberOfRepsLabel.text = "\(Int(repsSlider.value))"
        
        setNegative(label: timerLabel, numberLabel: numberOfTimerLabel, slider: timerSlider)
        setActive(label: repsLabel, numberLabel: numberOfRepsLabel, slider: repsSlider)
    }
    
    @objc private func timerSliderChanged() {
        
        let (min, sec) = { (secs: Int) -> (Int, Int) in
            return (secs / 60, secs % 60)}(Int(timerSlider.value))
        
        numberOfTimerLabel.text = (sec != 0 ? "\(min) min \(sec) sec" : "\(min) min")
        
        setNegative(label: repsLabel, numberLabel: numberOfRepsLabel, slider: repsSlider)
        setActive(label: timerLabel, numberLabel: numberOfTimerLabel, slider: timerSlider)
    }
}

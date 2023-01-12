//
//  DateAndRepeatView.swift
//  TrainingApp
//
//  Created by Дария Григорьева on 12.01.2023.
//

import UIKit

class DateAndRepeatView: UIView {
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.tintColor = .specialGreen
        return datePicker
    }()
    
    private let repeatLabel: UILabel = {
        let label = UILabel()
        label.text = "Repeat every 7 days"
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        return label
    }()
    
    private let dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    private let repeatStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        return stackView
    }()
    
    let repeatSwitch: UISwitch = {
        let repeatSwitch = UISwitch()
        repeatSwitch.isOn = true
        repeatSwitch.onTintColor = .specialGreen
        return repeatSwitch
    }()
    
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
        
        dateStackView.addArrangedSubview(dateLabel)
        dateStackView.addArrangedSubview(datePicker)
        repeatStackView.addArrangedSubview(repeatLabel)
        repeatStackView.addArrangedSubview(repeatSwitch)
        
        contentStackView.addArrangedSubview(dateStackView)
        contentStackView.addArrangedSubview(repeatStackView)
        
        addSubviews(contentStackView)
        
        
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
        ])
    }
}

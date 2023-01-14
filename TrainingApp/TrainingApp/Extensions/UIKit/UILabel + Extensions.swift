//
//  UILabel + Extensions.swift
//  TrainingApp
//
//  Created by Дария Григорьева on 14.01.2023.
//

import UIKit

extension UILabel {
    convenience init(text: String = "") {
        self.init()
        self.text = text
        self.font = .robotoMedium14()
        self.textColor = .specialLightBrown
    }
}

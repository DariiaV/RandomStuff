//
//  UIStackView + Extensions.swift
//  TrainingApp
//
//  Created by Дария Григорьева on 11.01.2023.
//

import UIKit
extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIStackView {
    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach { view in
            addArrangedSubview(view)
        }
    }
}

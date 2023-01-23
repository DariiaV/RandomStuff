//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 23.01.2023.
//

import UIKit

extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
}

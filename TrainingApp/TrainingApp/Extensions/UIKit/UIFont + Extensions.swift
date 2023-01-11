//
//  UIFont + Extensions.swift
//  TrainingApp
//
//  Created by Дария Григорьева on 11.01.2023.
//

import UIKit

extension UIFont {
    
    //label.font = UIFont(name: "Roboto-Medium", size: 24)

    //Medium
    static func robotoMedium24() -> UIFont? {
        return UIFont.init(name: "Roboto-Medium", size: 24)
    }
    
    static func robotoMedium12() -> UIFont? {
        return UIFont.init(name: "Roboto-Medium", size: 12)
    }
    
    static func robotoMedium14() -> UIFont? {
        return UIFont.init(name: "Roboto-Medium", size: 14)
    }
    
    static func robotoMedium18() -> UIFont? {
        return UIFont.init(name: "Roboto-Medium", size: 18)
    }
    
    //Bold
    static func robotoBold16() -> UIFont? {
        return UIFont.init(name: "Roboto-Bold", size: 16)
    }
    
    static func robotoBold20() -> UIFont? {
        return UIFont.init(name: "Roboto-Bold", size: 20)
    }
}

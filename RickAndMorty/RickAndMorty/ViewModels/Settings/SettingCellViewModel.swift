//
//  SettingCellViewModel.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 27.01.2023.
//

import UIKit

struct SettingCellViewModel: Identifiable, Hashable {
    
    let id = UUID()
    
    private let type: SettingsOption
    
    // MARK: -  Init
    init(type: SettingsOption) {
        self.type = type
    }
    // MARK: - Public
    var image: UIImage? {
        return type.iconImage
    }
    
    var title: String {
        return type.displayTitle
    }
    
    var iconContainerColor: UIColor {
        return type.iconContainerColor
    }
    
}

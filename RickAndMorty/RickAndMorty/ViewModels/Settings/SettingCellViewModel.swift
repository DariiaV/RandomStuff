//
//  SettingCellViewModel.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 27.01.2023.
//

import UIKit

struct SettingCellViewModel: Identifiable {
    
    let id = UUID()
    
    let type: SettingsOption
    let onTapHandler: (SettingsOption) -> Void
    
    // MARK: -  Init
    init(type: SettingsOption, onTapHandler: @escaping (SettingsOption) -> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
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

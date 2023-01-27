//
//  SettingsViewController.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 19.01.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private let viewModel = SettingsViewViewModel(cellViewModels: SettingsOption.allCases.compactMap({
        return SettingCellViewModel(type: $0)
    }))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Settings"
    }
    
    
    
}

//
//  SearchInputViewViewModel.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 31.01.2023.
//

import UIKit

final class SearchInputViewViewModel {
    
    private let type: SearchViewController.Config.`Type`
    
    enum DynamicOption: String {
        case status = "Status"
        case gender = "Gender"
        case locationType = "location Type"
        
        var choices: [String] {
            switch self {
            case .status:
                return ["alive", "dead", "unknown"]
            case .gender:
                return ["male", "female", "genderless", "unknown"]
            case .locationType:
                return ["cluster", "planet", "microverse"]
            }
        }
    }
    
    init(type: SearchViewController.Config.`Type`) {
        self.type = type
    }
    
    var hasDynamicOptions: Bool {
        switch self.type {
        case .character, .location:
            return true
        case .episode:
            return false
        }
    }
    
    var options: [DynamicOption] {
        switch self.type {
        case .character:
            return [.status, .gender]
        case .episode:
            return []
        case .location:
            return [.locationType]
        }
    }
    
    var searchPlaceholderText: String {
        switch self.type {
        case .character:
            return "Character Name"
        case .episode:
            return "Episode Title"
        case .location:
            return "Location Name"
        }
    }
}

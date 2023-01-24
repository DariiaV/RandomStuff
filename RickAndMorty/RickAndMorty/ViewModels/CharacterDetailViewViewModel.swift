//
//  CharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 23.01.2023.
//

import Foundation

final class CharacterDetailViewViewModel {
    
    private let character: Character
    
    enum SectionType: CaseIterable {
        case photo
        case information
        case episodes
    }
    
    let sections = SectionType.allCases
    
    // MARK: - Init
    
    init(character: Character) {
        self.character = character
    }
    
    private var requestUrl: URL? {
        return URL(string: character.url)
    }
    
    var title: String {
        character.name.uppercased()
    }
}

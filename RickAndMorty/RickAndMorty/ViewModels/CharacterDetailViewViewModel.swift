//
//  CharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 23.01.2023.
//

import Foundation

final class CharacterDetailViewViewModel {
    
    private let character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    var title: String {
        character.name.uppercased()
    }
}

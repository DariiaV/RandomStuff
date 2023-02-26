//
//  SearchResultViewModel.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 26.02.2023.
//

import Foundation

enum SearchResultViewModel {
    case characters([CharacterCollectionViewCellViewModel])
    case episodes([CharacterEpisodeCollectionViewCellViewModel])
    case locations([LocationTableViewCellViewModel])
}

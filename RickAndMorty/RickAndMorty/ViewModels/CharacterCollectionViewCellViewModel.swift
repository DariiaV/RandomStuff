//
//  CharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 23.01.2023.
//

import Foundation

final class CharacterCollectionViewCellViewModel: Hashable, Equatable {
    
    let characterName: String
    private let characterStatus: CharacterStatus
    private let characterImageUrl: URL?
    
    // MARK: - Init
    init(characterName: String, characterStatus: CharacterStatus, characterImageUrl: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    var characterStatusText: String {
        return "Status: \(characterStatus.text)"
    }
    
    func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        // MARK: - Abstract to Image Manager
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
    // MARK: - Hashable
    static func == (lhs: CharacterCollectionViewCellViewModel,
                    rhs: CharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
}

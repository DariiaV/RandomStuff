//
//  CharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 23.01.2023.
//

import Foundation

final class CharacterCollectionViewCellViewModel {
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
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}

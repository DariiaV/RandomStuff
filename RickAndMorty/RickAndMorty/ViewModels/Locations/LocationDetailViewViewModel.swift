//
//  LocationDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 30.01.2023.
//

import UIKit


protocol LocationDetailViewViewModelDelegate: AnyObject {
    func didFetchLocationDetails()
}

final class LocationDetailViewViewModel {
    
    weak var delegate: LocationDetailViewViewModelDelegate?
    
    private let endpointUrl: URL?
    private var dataTuple: (location: Location, characters: [Character])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchLocationDetails()
        }
    }
    
    enum SectionType {
        case information(viewModels: [EpisodeInfoCollectionViewCellViewModel])
        case characters(viewModels: [CharacterCollectionViewCellViewModel])
    }
    
    public private(set) var cellViewModels: [SectionType] = []
    
    // MARK: - Init
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
    }
    ///Fetch backing location model
    func fetchLocationData() {
        guard let url = endpointUrl, let request = Request(url: url) else {
            return
        }
        Service.shared.execute(request, expecting: Location.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacters(location: model)
            case .failure:
                break
            }
        }
    }
    
    func character(at index: Int) -> Character? {
        guard let dataTuple = dataTuple else {
            return nil
        }
        return dataTuple.characters[index]
    }
    
    private func createCellViewModels() {
        guard let dataTuple = dataTuple else {
            return
        }
        let location = dataTuple.location
        let characters = dataTuple.characters
        var createdString = location.created
        if let date = CharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: location.created) {
            createdString = CharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: date)
        }
        
        cellViewModels = [
            .information(viewModels: [
                .init(title: "Location Name", value: location.name),
                .init(title: "Type", value: location.type),
                .init(title: "EDimension", value: location.dimension),
                .init(title: "Created", value: createdString),
            ]),
            .characters(viewModels: characters.compactMap({ character in
                return CharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image))
            }))
        
        ]
    }
    
    private func fetchRelatedCharacters(location: Location) {
        let requests: [Request] = location.residents.compactMap({
            return URL(string: $0)
        }).compactMap({
            return Request(url: $0)
        })
        
        let group = DispatchGroup()
        var characters: [Character] = []
        for request in requests {
            group.enter()
            Service.shared.execute(request, expecting: Character.self) { result in
                defer{
                    group.leave()
                }
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure:
                    break
                }
            }
        }
        group.notify(queue: .main) {
            self.dataTuple = (location: location, characters: characters)
        }
    }
}


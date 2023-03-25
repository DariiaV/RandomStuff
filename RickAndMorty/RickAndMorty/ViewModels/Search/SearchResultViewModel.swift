//
//  SearchResultViewModel.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 26.02.2023.
//

import Foundation

final class SearchResultViewModel {
    private(set) var results: SearchResultType
    private var next: String?
    
    init(results: SearchResultType, next: String?) {
        self.results = results
        self.next = next
    }
    
    private (set) var isLoadingMoreResults = false
    
    var shouldShowLoadMoreIndicator: Bool {
        return next != nil
    }
    
    func fetchAdditionalLocations(completion: @escaping ([LocationTableViewCellViewModel]) -> Void) {
        guard !isLoadingMoreResults else {
            return
        }
        
        guard let nextUrlString = next,
              let url = URL(string: nextUrlString) else {
            return
        }
        
        isLoadingMoreResults = true
        
        guard let request = Request(url: url) else {
            isLoadingMoreResults = false
            return
        }
        Service.shared.execute(request, expecting: GetAllLocationsResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.results
                let info = responseModel.info
                strongSelf.next = info.next //Capture new pagination url
                let additionalLocations = moreResults.compactMap({
                    return LocationTableViewCellViewModel(location: $0)
                })
                var newResults: [LocationTableViewCellViewModel] = []
                switch strongSelf.results {
                case .characters, .episodes:
                    break
                case .locations(let existingResults):
                    newResults = existingResults + additionalLocations
                    strongSelf.results = .locations(newResults)
                    break
                }
                
                DispatchQueue.main.async {
                    strongSelf.isLoadingMoreResults = false
                    //Notify via callback
                    completion(newResults)
                }
            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreResults = false
            }
        }
        
    }
}

enum SearchResultType {
    case characters([CharacterCollectionViewCellViewModel])
    case episodes([CharacterEpisodeCollectionViewCellViewModel])
    case locations([LocationTableViewCellViewModel])
}

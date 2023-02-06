//
//  LocationViewViewModel.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 30.01.2023.
//

import UIKit

protocol LocationViewViewModelDelegate: AnyObject {
    func didFetchInitialLocations()
}
final class LocationViewViewModel {
    
    weak var delegate: LocationViewViewModelDelegate?
    
    private var locations: [Location] = [] {
        didSet {
            for location in locations {
                let cellViewModel = LocationTableViewCellViewModel(location: location)
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                }
            }
        }
    }
    private(set) var cellViewModels: [LocationTableViewCellViewModel] = []
    private var apiInfo: GetAllLocationsResponse.Info?
    
    private var hasMoreResults: Bool {
        return false
    }
    init() {}
    
    func location(at index: Int) -> Location? {
        guard index < locations.count, index >= 0 else {
            return nil
        }
        return self.locations[index]
    }
    
    func fetchLocations() {
        Service.shared.execute(.listLocationsRequest, expecting: GetAllLocationsResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.apiInfo = model.info
                self?.locations = model.results
                DispatchQueue.main.async {
                    self?.delegate?.didFetchInitialLocations()
                }
            case .failure(_):
                break
            }
        }
        
    }
    
}

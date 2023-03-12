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
    
    
    var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    private var apiInfo: GetAllLocationsResponse.Info?
    
    private var hasMoreResults: Bool {
        return false
    }
    
    private var didFinishPagination: (() -> Void)?
    
    var isLoadingMoreLocations = false
    
    init() {}
    
    func registerDidFinishPaginationBlock(_ block: @escaping () -> Void) {
        self.didFinishPagination = block
    }
    
    ///Paginate if additional locations are needed
    func fetchAdditionalLocations() {
        guard !isLoadingMoreLocations else {
            return
        }
        
        guard let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else {
            return
        }
        
        isLoadingMoreLocations = true
        
        guard let request = Request(url: url) else {
            isLoadingMoreLocations = false
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
                strongSelf.apiInfo = info
                strongSelf.cellViewModels.append(contentsOf: moreResults.compactMap({
                    return LocationTableViewCellViewModel(location: $0)
                }))
                DispatchQueue.main.async {
                    strongSelf.isLoadingMoreLocations = false
                    //Notify via callback
                    strongSelf.didFinishPagination?()
                }
            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreLocations = false
            }
        }
        
    }
    
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

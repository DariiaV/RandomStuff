//
//  LocationViewViewModel.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 30.01.2023.
//

import UIKit

final class LocationViewViewModel {
    
    private var locations: [Location] = []
    private var cellViewModels: [String] = []
    
    private var hasMoreResults: Bool {
        return false
    }
    init() {
        
    }
    
    func fetchLocations() {
        Service.shared.execute(.listLocationsRequest, expecting: String.self) { result in
            switch result {
            case .success(let model):
                break
            case .failure(let error):
                break
            }
        }
        
    }
    
}

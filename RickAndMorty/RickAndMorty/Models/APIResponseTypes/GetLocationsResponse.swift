//
//  GetLocationsResponse.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 30.01.2023.
//

import Foundation

struct GetAllLocationsResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [Location]
}

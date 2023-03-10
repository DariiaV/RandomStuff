//
//  GetAllEpisodesResponse.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 26.01.2023.
//

import Foundation

struct GetAllEpisodesResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [Episode]
}

//
//  Episode.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 19.01.2023.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}

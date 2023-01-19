//
//  CharacterStatus.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 19.01.2023.
//

import Foundation

enum CharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
}

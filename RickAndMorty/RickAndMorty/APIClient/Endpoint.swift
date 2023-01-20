//
//  Endpoint.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 19.01.2023.
//

import Foundation
/// Represents unique API endpoint
@frozen enum Endpoint: String {
    case character //endpoint to get character info
    case location //endpoint to get location info
    case episode //endpoint to get episode info
}

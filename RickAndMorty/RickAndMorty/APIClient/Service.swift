//
//  Service.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 19.01.2023.
//

import Foundation
// MARK: - Primary API service object to get Rick and Morty data
final class Service {
    // MARK: - Shared singleton instance
    static let shared = Service()
    // MARK: - Privatized constructor
    private init() {}
    // MARK: - API Call Parameters: - request: Request instance, - completion: Callback with data or error
    func execute(_ request: Request, completion: @escaping () -> Void) {
        
    }
}

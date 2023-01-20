//
//  Service.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 19.01.2023.
//

import Foundation
/// Primary API service object to get Rick and Morty data
final class Service {
    
    static let shared = Service()
    
    private init() {}
    
    ///API Call Parameters: - request: Request instance, - completion: Callback with data or error
    func execute<T: Codable>(
        _ request: Request,
        expecting type: T.Type,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        
    }
}

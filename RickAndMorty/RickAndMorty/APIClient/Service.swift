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
    
    private let cacheManager = APICacheManager()
    
    ///Privatized Init
    private init() {}
    
    enum ServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    ///API Call Parameters: - request: Request instance, - completion: Callback with data or error
    func execute<T: Codable>(
        _ request: Request,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        if let cachedData = cacheManager.cachedResponse(for: request.endpoint, url: request.url) {
            do {
                let result = try JSONDecoder().decode(type.self, from: cachedData)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
            return
        }
        
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(ServiceError.failedToCreateRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ServiceError.failedToGetData))
                return
            }
            ///Decode response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                self?.cacheManager.setCache(for: request.endpoint, url: request.url, data: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
    
    private func request(from Request: Request) -> URLRequest? {
        guard let url = Request.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = Request.httpMethod
        return request
    }
}

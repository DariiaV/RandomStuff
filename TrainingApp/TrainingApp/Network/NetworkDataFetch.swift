//
//  NetworkDataFetch.swift
//  TrainingApp
//
//  Created by Дария Григорьева on 17.01.2023.
//

import Foundation

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    private init() {}
    
    func fetchWeather(lat: Double,
                      lon: Double,
                      response: @escaping (WeatherModel?, Error?) -> Void) {
        NetworkRequest.shared.requestData(latitude: lat,
                                          longitude: lon) { result in
            
            switch result {
            case .success(let data):
                do {
                    let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                    response(weather, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                response(nil, error)
            }
        }
    }
}

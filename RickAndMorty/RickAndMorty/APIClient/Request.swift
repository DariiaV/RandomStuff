//
//  Request.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 19.01.2023.
//

import Foundation
///Object that represents a singlet API call
final class Request {
    ///API Constants
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    ///Desired endpoint
    private let endpoint: Endpoint
    ///Path components for API, if any
    private let pathComponents: [String]
    ///Query arguments for API, if any
    private let queryParameters: [URLQueryItem]
    
    ///Constructed url for the api request in string format
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else {
                    return nil
                }
                return "\($0.name) = \(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    ///Computed & constructed API url
    var url: URL? {
        return URL(string: urlString)
    }
    ///Desired http method
    let httpMethod = "GET"
    
    init(endpoint: Endpoint,
         pathComponents: [String] = [],
         queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}

extension Request {
    static let listCharactersRequest = Request(endpoint: .character)
}

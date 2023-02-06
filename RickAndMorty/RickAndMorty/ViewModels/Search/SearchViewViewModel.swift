//
//  SearchViewViewModel.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 31.01.2023.
//

import UIKit

final class SearchViewViewModel {
    
    let config: SearchViewController.Config
    private var optionMap: [SearchInputViewViewModel.DynamicOption: String] = [:]
    private var searchText = ""
    private var optionMapUpdateBlock: (((SearchInputViewViewModel.DynamicOption, String)) -> Void)?
    private var searchResultHandler: (() -> Void)?
    // MARK: - Init
    init(config: SearchViewController.Config) {
        self.config = config
    }
    
    func registerSearchResultHandler(_ block: @escaping () -> Void) {
        self.searchResultHandler = block
    }
    
    func executeSearch() {
        searchText = "Rick"
        var queryParams: [URLQueryItem] = [URLQueryItem(name: "name", value: searchText)]
        
        queryParams.append(contentsOf: optionMap.enumerated().compactMap({ _, element in
            let key: SearchInputViewViewModel.DynamicOption = element.key
            let value: String = element.value
            return URLQueryItem(name: key.queryArgument, value: value)
        }))
        
        let request = Request(endpoint: config.type.endPoint, queryParameters: queryParams)
        
        print(request.url?.absoluteString)
      
        Service.shared.execute(request, expecting: GetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Search results found: \(model.results.count)")
            case .failure(_):
                break
            }
        }
    }
    
    func set(query text: String) {
        self.searchText = text
    }
    
    func set(value: String, for option: SearchInputViewViewModel.DynamicOption) {
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    func registerOptionChangeBlock(_ block: @escaping ((SearchInputViewViewModel.DynamicOption, String)) -> Void) {
        self.optionMapUpdateBlock = block
    }
}

//
//  SearchViewController.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 26.01.2023.
//

import UIKit
///Configurable controller to search
final class SearchViewController: UIViewController {
    ///Configuration for search session
    struct Config {
        enum `Type` {
            case character
            case episode
            case location
            
            var title: String {
                switch self {
                case .character:
                    return "Search Characters"
                case .episode:
                    return "Search Episode"
                case .location:
                    return "Search Location"
                }
            }
        }
        let type: `Type`
    }
    
    private let viewModel: SearchViewViewModel
    private let searchView: SearchView
    
    // MARK: - Init
    init(config: Config) {
        let viewModel = SearchViewViewModel(config: config)
        self.viewModel = viewModel
        self.searchView = SearchView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.config.type.title
        view.backgroundColor = .systemBackground
        setUpViews()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(didTapExecuteSearch))
        searchView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchView.presentKeyboard()
    }
    
    private func setUpViews() {
        view.addSubviews(searchView)
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func didTapExecuteSearch() {
        // viewModel.executeSearch()
    }
}

extension SearchViewController: SearchViewDelegate {
    // MARK: - SearchViewDelegate
    func rmSearchView(_ searchView: SearchView, didSelectOption option: SearchInputViewViewModel.DynamicOption) {
        let vc = SearchOptionPickerViewController(option: option) { selection in
            print("Did select \(selection)")
        }
        vc.sheetPresentationController?.detents = [.medium()]
        vc.sheetPresentationController?.prefersGrabberVisible = true
        present(vc, animated: true)
    }
}

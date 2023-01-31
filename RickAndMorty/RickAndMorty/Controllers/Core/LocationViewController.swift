//
//  LocationViewController.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 19.01.2023.
//

import UIKit

final class LocationViewController: UIViewController {
    
    private let primaryView = LocationView()
    private let viewModel = LocationViewViewModel()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        primaryView.delegate = self
        title = "Locations"
        addSearchButton()
        setUpViews()
        viewModel.delegate = self
        viewModel.fetchLocations()
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    private func setUpViews() {
        view.backgroundColor = .systemBackground
        view.addSubviews(primaryView)
        
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func didTapSearch() {
        let vc = SearchViewController(config: .init(type: .location))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LocationViewController: LocationViewViewModelDelegate {
    // MARK: - LocationViewViewModelDelegate
    func didFetchInitialLocations() {
        primaryView.configure(with: viewModel)
    }
}

extension LocationViewController: LocationViewDelegate {
    // MARK: - LocationViewDelegate
    func locationView(_ locationView: LocationView, didSelect location: Location) {
        let vc = LocationDetailViewController(location: location)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

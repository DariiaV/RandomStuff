//
//  LocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 30.01.2023.
//

import UIKit

final class LocationDetailViewController: UIViewController {
    
    private let viewModel: LocationDetailViewViewModel
    private let detailView = LocationDetailView()
    
        // MARK: - Init
    init(location: Location) {
        let url = URL(string: location.url)
        self.viewModel = LocationDetailViewViewModel(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Location"
        view.backgroundColor = .systemBackground
        setUpView()
        setUpNavigationItem()
        viewModel.delegate = self
        detailView.delegate = self
        viewModel.fetchLocationData()
    }
    
    private func setUpView() {
        view.addSubviews(detailView)
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
    }
    
    @objc private func didTapShare() {
        
    }
}

extension LocationDetailViewController: LocationDetailViewViewModelDelegate {
    // MARK: - LocationDetailViewViewModelDelegate
    func didFetchLocationDetails() {
        detailView.configure(with: viewModel)
    }
}

extension LocationDetailViewController: LocationDetailViewDelegate {
    // MARK: - LocationDetailViewDelegate
    func episodeDetailView(_ detailView: LocationDetailView, didSelect character: Character) {
        let vc = CharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)

    }
}

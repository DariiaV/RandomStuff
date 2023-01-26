//
//  EpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 26.01.2023.
//

import UIKit
///VC to show details about single episode
final class EpisodeDetailViewController: UIViewController {
    
    private let viewModel: EpisodeDetailViewViewModel
    private let detailView = EpisodeDetailView()
    
    // MARK: - Init
    init(url: URL?) {
        self.viewModel = EpisodeDetailViewViewModel(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Episode"
        setUpView()
        setUpNavigationItem()
        viewModel.delegate = self
        viewModel.fetchEpisodeData()
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

extension EpisodeDetailViewController: EpisodeDetailViewViewModelDelegate {
    // MARK: - EpisodeDetailViewViewModelDelegate
    func didFetchEpisodeDetails() {
        detailView.configure(with: viewModel)
    }
    
    
}

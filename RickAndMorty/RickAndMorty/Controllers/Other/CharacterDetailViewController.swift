//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 23.01.2023.
//

import UIKit
/// Controller to show into about single character
final class CharacterDetailViewController: UIViewController {
    
    private let viewModel: CharacterDetailViewViewModel
    private let detailView: CharacterDetailView
    
    // MARK: - Init
    init(viewModel: CharacterDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = CharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = viewModel.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        setupView()
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
    }
    
    private func setupView() {
        view.addSubviews(detailView)
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func didTapShare() {
        
    }
}

extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if indexPath.section == 0 {
            cell.backgroundColor = .systemPink
        } else if indexPath.section == 1 {
            cell.backgroundColor = .systemGreen
        } else {
            cell.backgroundColor = .systemBlue
        }
        return cell
    }
    
}

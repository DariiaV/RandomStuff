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
    
    init(viewModel: CharacterDetailViewViewModel) {
        self.viewModel = viewModel
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
    }
}

//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Дария Григорьева on 11.02.2023.
//

import UIKit

class GameViewController: UIViewController {
    
    var name: String?
    
    private let backgroundView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "background")
        return view
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Scores:"
        label.font = UIFont(name: "Marker Felt Thin", size: 20)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private let playerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Player:"
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private let computerLabel: UILabel = {
        let label = UILabel()
        label.text = "Computer:"
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private let playerScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let computerScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GameCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
        return collectionView
    }()
    
    private lazy var buttonClose: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        return button
    }()
    
    private let identifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        playerNameLabel.text = name
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setUpViews() {
        view.addSubviews(backgroundView,
                         scoreLabel,
                         buttonClose,
                         playerNameLabel,
                         computerLabel,
                         playerScoreLabel,
                         computerScoreLabel,
                         collectionView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 79),
            scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scoreLabel.heightAnchor.constraint(equalToConstant: 20),
            
            buttonClose.leadingAnchor.constraint(equalTo: scoreLabel.trailingAnchor),
            buttonClose.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            buttonClose.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor),
            
            playerNameLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 10),
            playerNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            playerNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            computerLabel.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor, constant: 10),
            computerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            computerLabel.heightAnchor.constraint(equalToConstant: 20),
            
            playerScoreLabel.leadingAnchor.constraint(equalTo: playerNameLabel.trailingAnchor, constant: 10),
            playerScoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerScoreLabel.centerYAnchor.constraint(equalTo: playerNameLabel.centerYAnchor),
            
            computerScoreLabel.leadingAnchor.constraint(equalTo: computerLabel.trailingAnchor, constant: 10),
            computerScoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            computerScoreLabel.centerYAnchor.constraint(equalTo: computerLabel.centerYAnchor),
            
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 302),
            collectionView.widthAnchor.constraint(equalToConstant: 302)
        ])
    }
    
}

extension GameViewController: UICollectionViewDataSource {
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? GameCell else {
            return UICollectionViewCell()
        }
        let image = UIImage(named: "ex")
        cell.setupCellImage(image: image)
        return cell
    }
}

extension GameViewController: UICollectionViewDelegate {
    // MARK: - UICollectionViewDelegate
}

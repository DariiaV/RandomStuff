//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Дария Григорьева on 11.02.2023.
//

import UIKit

enum Box: Int {
    case one, two, three, four, five, six, seven, eight, nine
}

class GameViewController: UIViewController {
    
    var name: String?
    private let identifier = "cell"
    private lazy var ticTacToeModels = createModels()
    private var playerChoices: [Box] = []
    private var computerChoices: [Box] = []
    private var isTie = false
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
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray
        return collectionView
    }()
    
    private lazy var buttonClose: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(resetGame), for: .touchUpInside)
        return button
    }()
    
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
    
    private func createModels() -> [TicTacToeModel] {
        var models = [TicTacToeModel]()
        for index in 0...8 {
            models.append(TicTacToeModel(imageName: nil,
                                         isActive: true,
                                         index: index,
                                         box: Box(rawValue: index) ?? .one))
        }
        return models
    }
    
    private func checkIfWon() -> Bool {
        var correct = [[Box]]()
        let firstRow: [Box] = [.one, .two, .three]
        let secondRow: [Box] = [.four, .five, .six]
        let thirdRow: [Box] = [.seven, .eight, .nine]
        
        let firstCol: [Box] = [.one, .four, .seven]
        let secondCol: [Box] = [.two, .five, .eight]
        let thirdCol: [Box] = [.three, .six, .nine]
        
        let backwardSlash: [Box] = [.one, .five, .nine]
        let forwardSlash: [Box] = [.three, .five, .seven]
        
        correct.append(firstRow)
        correct.append(secondRow)
        correct.append(thirdRow)
        correct.append(firstCol)
        correct.append(secondCol)
        correct.append(thirdCol)
        correct.append(backwardSlash)
        correct.append(forwardSlash)
        
        var userMatch = 0
        var computerMatch = 0
        
        for valid in correct {
            userMatch = playerChoices.filter { valid.contains($0) }.count
            computerMatch = computerChoices.filter { valid.contains($0) }.count
            
            if userMatch == valid.count {
                playerScoreLabel.text = String((Int(playerScoreLabel.text ?? "0") ?? 0) + 1)
                return true
            } else if computerMatch == valid.count {
                computerScoreLabel.text = String((Int(computerScoreLabel.text ?? "0") ?? 0) + 1)
                return true
            }
        }
        
        if computerChoices.count + playerChoices.count == 9 {
            isTie = true
            return true
        }
        return false
    }
    
    @objc private func resetGame() {
        ticTacToeModels = createModels()
        playerChoices = []
        computerChoices = []
        isTie = false
        collectionView.reloadData()
    }
    
    private func showAlert(title: String) {
        let vc = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Next", style: .default) { _ in
            self.resetGame()
        }
        vc.addAction(action)
        present(vc, animated: true)
    }
 
    
}

extension GameViewController: UICollectionViewDataSource {
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ticTacToeModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? GameCell else {
            return UICollectionViewCell()
        }
        let model = ticTacToeModels[indexPath.item]
        cell.setupCellImage(imageName: model.imageName)
        return cell
    }
}

extension GameViewController: UICollectionViewDelegate {
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = ticTacToeModels[indexPath.item]
        guard model.isActive else {
            return
        }
        ticTacToeModels[indexPath.item].imageName = "oh"
        ticTacToeModels[indexPath.item].isActive = false
        playerChoices.append(model.box)
        collectionView.reloadItems(at: [indexPath])
        guard !checkIfWon() else {
            isTie ? showAlert(title: "Is Tie") : showAlert(title: "You win")
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.computerPlay()
        }
    }
    
    private func computerPlay() {
        let models = ticTacToeModels.filter{$0.isActive}
        guard !models.isEmpty,
            let index = models.randomElement()?.index else {
            return
        }
        ticTacToeModels[index].isActive = false
        ticTacToeModels[index].imageName = "ex"
        computerChoices.append(ticTacToeModels[index].box)
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.reloadItems(at: [indexPath])
        guard !checkIfWon() else {
            showAlert(title: "You lose")
            return
        }
    }
}

//
//  CharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 25.01.2023.
//

import UIKit

final class CharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "CharacterEpisodeCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: CharacterEpisodeCollectionViewCellViewModel) {
        
    }
}

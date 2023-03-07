//
//  SearchResultsView.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 06.03.2023.
//

import UIKit
protocol SearchResultsViewDelegate: AnyObject {
    func rmSearchResultsView(_ resultsView: SearchResultsView, didTapLocationAt index: Int)
}
///Shows search results UI(table or collection as needed)
final class SearchResultsView: UIView {
    
    weak var delegate: SearchResultsViewDelegate?
    private var viewModel: SearchResultViewModel? {
        didSet {
            self.processViewModel()
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.cellIdentifier)
        table.isHidden = true
        return table
    }()
    
    private var locationCellViewModels: [LocationTableViewCellViewModel] = []
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        addSubviews(tableView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func processViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        switch viewModel {
        case .characters(let viewModels):
            setUpCollectionView()
        case .episodes(let viewModels):
            setUpCollectionView()
        case .locations(let viewModels):
            setUpTableView(viewModels: viewModels)
        }
    }
    
    private func setUpCollectionView() {
        
    }
    
    private func setUpTableView(viewModels: [LocationTableViewCellViewModel]) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
        self.locationCellViewModels = viewModels
        tableView.reloadData()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(with viewModel: SearchResultViewModel) {
        self.viewModel = viewModel
    }
}

extension SearchResultsView: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.cellIdentifier, for: indexPath) as? LocationTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: locationCellViewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.rmSearchResultsView(self, didTapLocationAt: indexPath.row)
    }
}

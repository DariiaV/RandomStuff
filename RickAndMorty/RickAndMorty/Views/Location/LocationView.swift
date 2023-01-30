//
//  LocationView.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 30.01.2023.
//

import UIKit

protocol LocationViewDelegate: AnyObject {
    func locationView(_ locationView: LocationView, didSelect location: Location)
}
final class LocationView: UIView {
    
    weak var delegate: LocationViewDelegate?
    
    private var viewModel: LocationViewViewModel? {
        didSet {
            spinner.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 1
            }
        }
    }
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.cellIdentifier)
        table.alpha = 0
        table.isHidden = true
        return table
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        setUpViews()
        spinner.startAnimating()
        configureTable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        addSubviews(tableView, spinner)
        NSLayoutConstraint.activate([
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configure(with viewModel: LocationViewViewModel) {
        self.viewModel = viewModel
    }
}

extension LocationView: UITableViewDelegate {
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let locationModel = viewModel?.location(at: indexPath.row) else {
            return
        }
        delegate?.locationView(self, didSelect: locationModel)
    }
}

extension LocationView: UITableViewDataSource {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModels = viewModel?.cellViewModels else {
            fatalError()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.cellIdentifier, for: indexPath) as? LocationTableViewCell else {
            return UITableViewCell()
        }
        let cellViewModel = cellViewModels[indexPath.row]
        cell.configure(with: cellViewModel)
        return cell
    }
    
    

    
}

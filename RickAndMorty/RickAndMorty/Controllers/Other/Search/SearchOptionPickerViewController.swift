//
//  SearchOptionPickerViewController.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 04.02.2023.
//

import UIKit

final class SearchOptionPickerViewController: UIViewController {
    
    private let option: SearchInputViewViewModel.DynamicOption
    private let selectionBlock: ((String) -> Void)
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    // MARK: - Init
    init(option: SearchInputViewViewModel.DynamicOption, selection: @escaping (String) -> Void) {
        self.option = option
        self.selectionBlock = selection
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setUpTable()
    }
    
    private func setUpTable() {
        view.addSubviews(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
extension SearchOptionPickerViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return option.choices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let choice = option.choices[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = choice.uppercased()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let choice = option.choices[indexPath.row]
        self.selectionBlock(choice)
        dismiss(animated: true)
    }
    
    
}


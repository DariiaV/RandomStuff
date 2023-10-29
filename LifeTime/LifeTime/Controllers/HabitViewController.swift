//
//  HabitViewController.swift
//  LifeTime
//
//  Created by Дария Григорьева on 01.08.2023.
//

import UIKit

class HabitViewController: UIViewController {
    
    private let tableView = UITableView()
    private let cellReuseIdentifier = "cell"
    private var habit: [TimerModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationItem()
        setupAppearanceNavigationBar()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigationItem() {
        title = "Habits"
        let rightItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewHabits))
        rightItem.tintColor = UIColor.systemPurple
        navigationItem.rightBarButtonItem = rightItem
    }
    
    private func setupAppearanceNavigationBar() {
        let navVC = navigationController
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        let color = UIColor.systemPurple
        appearance.titleTextAttributes = [.foregroundColor: color]
        navVC?.navigationBar.standardAppearance = appearance
        navVC?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc private func addNewHabits() {
        
    }
}

extension HabitViewController: UITableViewDataSource {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        habit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        //cell.textLabel?.text = habit[indexPath.row]
        cell.textLabel?.font = .systemFont(ofSize: 20)
        cell.textLabel?.textColor = .systemPurple
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension HabitViewController: UITableViewDelegate {
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailTimerViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

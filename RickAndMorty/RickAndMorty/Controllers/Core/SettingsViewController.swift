//
//  SettingsViewController.swift
//  RickAndMorty
//
//  Created by Дария Григорьева on 19.01.2023.
//
import StoreKit
import SafariServices
import SwiftUI
import UIKit

final class SettingsViewController: UIViewController {
    
    private var settingSwiftUIController: UIHostingController<SettingsView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Settings"
        addSwiftUIController()
    }
    
    private func addSwiftUIController() {
        let settingSwiftUIController = UIHostingController(rootView: SettingsView(viewModel: SettingsViewViewModel(cellViewModels: SettingsOption.allCases.compactMap({
            return SettingCellViewModel(type: $0) { [weak self] option in
                self?.handleTap(option: option)
            }
        }))))
        addChild(settingSwiftUIController)
        settingSwiftUIController.didMove(toParent: self)
        view.addSubview(settingSwiftUIController.view)
        settingSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingSwiftUIController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingSwiftUIController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingSwiftUIController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            settingSwiftUIController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.settingSwiftUIController = settingSwiftUIController
    }
    
    private func handleTap(option: SettingsOption) {
        guard Thread.current.isMainThread else {
            return
        }
        
        if let url = option.targetUrl {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
            
        } else if option == .rateApp {
            if let windowScene = self.view.window?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
    }
    
}

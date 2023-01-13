//
//  MainTabBarController.swift
//  TrainingApp
//
//  Created by Дария Григорьева on 13.01.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupItems()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .specialTabBar
        tabBar.tintColor = .specialDarkGreen
        tabBar.unselectedItemTintColor = .specialGray
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.specialLightBrown.cgColor
    }
    
    private func setupItems() {
        let mainVC = generateVC(viewController: MainViewController(),
                                title: "Main",
                                image: UIImage(named: "tabBarMain"))
        let statisticVC = generateVC(viewController: StatisticViewController(), title: "Statistic", image: UIImage(named: "tabBarStatistic"))
        let profileVC = generateVC(viewController: ProfileViewController(), title: "Profile", image: UIImage(named: "tabBarProfile")
        )
        
        setViewControllers([mainVC, statisticVC, profileVC], animated: true)
        
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont(name: "Roboto-Bold", size: 12) as Any], for: .normal)
    }
    
    private func generateVC(viewController: UIViewController,
                            title: String,
                            image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
}

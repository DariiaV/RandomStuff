//
//  TabBarController.swift
//  LifeTime
//
//  Created by Дария Григорьева on 01.08.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setupTabBar()
    }
    
    private func generateTabBar() {
        viewControllers = [
            
            generateVC(
                viewController: UINavigationController(rootViewController: HabitViewController()),
                image: UIImage(systemName: "house.fill")
            ),
            
            generateVC(
                viewController: PomodoroViewController(),
                image: UIImage(systemName: "clock.arrow.2.circlepath")
            ),

            generateVC(
                viewController: StatisticsViewController(),
                image: UIImage(systemName: "chart.bar.doc.horizontal.fill")
            ),
            
            generateVC(
                viewController: ProfileViewController(),
                image: UIImage(systemName: "person")
            )
        ]
    }
    
    private func generateVC(viewController: UIViewController,image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .systemPink
        tabBar.unselectedItemTintColor = .systemPurple
    }
}


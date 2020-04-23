//
//  AppCoordinator.swift
//  AvengersApp
//
//  Created by Javier Laguna on 23/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        configureUI()

        let tabBarCoordinators: [Coordinator] = [
            AvengersCoordinator()
        ]
        
        tabBarCoordinators.forEach { [weak self] coordinator in
            guard let strongSelf = self else { return }
            
            strongSelf.addChildCoordinator(coordinator)
            coordinator.start()
        }
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        tabBarController.viewControllers = tabBarCoordinators.map { $0.presenter }
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    override func finish() {}
    
    // MARK: Private functions
    private func configureUI() {
        UINavigationBar.appearance().tintColor = .orange
    }
}

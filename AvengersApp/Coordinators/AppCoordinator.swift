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
    
    // MARK: Repositories Injection
    lazy var settingsRepository: SettingsRepository = {
        return SettingsRepositoryUserDefaults()
    }()
    
    lazy var avengersRepository: AvengersRepository = {
        return AvengersRepositoryCoreData()
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        configureUI()
        
        if settingsRepository.isFirstAppLaunch() {
            loadJsonData()
        }
        
        let tabBarCoordinators: [Coordinator] = [
            AvengersCoordinator(repository: avengersRepository),
            BattlesCoordinator(),
            VillainsCoordinator()
        ]
        
        tabBarCoordinators.forEach { [weak self] coordinator in
            guard let strongSelf = self else { return }
            
            strongSelf.addChildCoordinator(coordinator)
            coordinator.start()
        }
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = UIColor.blueMain
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

// MARK: Load JSON data
extension AppCoordinator {
    
    // TODO: DO ON OTHER THREAD
    private func loadJsonData() {
        do {
            try loadAvengers()
            
            settingsRepository.setFirstAppLaunch(false)
        } catch {
            Log.error(error.localizedDescription)
        }
    }
    
    private func loadAvengers() throws {
        guard let pathURL = Bundle.main.url(forResource: "avengers_data", withExtension: "json") else {
            return Log.error("Can not find `avengers_data` resource")
        }
        
        let data = try Data(contentsOf: pathURL)
        let heroList = try JSONDecoder().decode([Hero].self, from: data)
        
        let avengers: [Avenger] = heroList.compactMap {
            let avenger = avengersRepository.createAvenger()
            avenger?.name = $0.name
            avenger?.image = $0.image
            avenger?.power = Int16($0.power)
            avenger?.biography = $0.biography
            return avenger
        }
        
        avengersRepository.saveAvengers(avengers)
    }
}

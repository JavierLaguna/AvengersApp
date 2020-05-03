//
//  AppCoordinator.swift
//  AvengersApp
//
//  Created by Javier Laguna on 23/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    
    // MARK: Repositories Injection
    private let database = CoreDataDatabase()
    
    lazy private var settingsRepository: SettingsRepository = {
        return SettingsRepositoryUserDefaults()
    }()
    
    lazy private var avengersRepository: AvengersRepository = {
        return AvengersRepositoryCoreData(database: database)
    }()
    
    lazy private var battlesRepository: BattlesRepository = {
        return BattlesRepositoryCoreData(database: database)
    }()
    
    lazy private var villainsRepository: VillainsRepository = {
        return VillainsRepositoryCoreData(database: database)
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        
        if settingsRepository.isFirstAppLaunch() {
            loadJsonData()
        }
        
        let tabBarCoordinators: [Coordinator] = [
            AvengersCoordinator(repository: avengersRepository,
                                battlesRepository: battlesRepository),
            BattlesCoordinator(repository: battlesRepository,
                               avengersRepository: avengersRepository,
                               villainsRepository: villainsRepository),
            VillainsCoordinator(repository: villainsRepository,
                                battlesRepository: battlesRepository)
        ]
        
        tabBarCoordinators.forEach { [weak self] coordinator in
            guard let strongSelf = self else { return }
            
            strongSelf.addChildCoordinator(coordinator)
            coordinator.start()
        }
        
        let mainTabBarVM = MainTabBarViewModel(tabs: tabBarCoordinators.map { $0.presenter }, repository: settingsRepository)
        let mainTabBar = MainTabBarController(viewModel: mainTabBarVM)
        
        mainTabBarVM.viewDelegate = mainTabBar
        
        window.rootViewController = mainTabBar
        window.makeKeyAndVisible()
    }
    
    override func finish() {}
}

// MARK: Load JSON data
extension AppCoordinator {
    
    private func loadJsonData() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let strongSelf = self else { return }
            
            do {
                let avengers = try strongSelf.loadAvengersJSON()
                let villains = try strongSelf.loadVillainsJSON()
                
                DispatchQueue.main.async {
                    _ = strongSelf.avengersRepository.createAvengers(from: avengers)
                    _ = strongSelf.villainsRepository.createVillain(from: villains)
                    strongSelf.settingsRepository.setFirstAppLaunch(false)
                }
            } catch {
                Log.error(error.localizedDescription)
            }
        }
    }
    
    private func loadAvengersJSON() throws -> [Hero] {
        guard let pathURL = Bundle.main.url(forResource: "avengers_data", withExtension: "json") else {
            Log.error("Can not find `avengers_data` resource")
            return []
        }
        
        let data = try Data(contentsOf: pathURL)
        return try JSONDecoder().decode([Hero].self, from: data)
    }
    
    private func loadVillainsJSON() throws -> [Hero]  {
        guard let pathURL = Bundle.main.url(forResource: "villains_data", withExtension: "json") else {
            Log.error("Can not find `villains_data` resource")
            return []
        }
        
        let data = try Data(contentsOf: pathURL)
        return try JSONDecoder().decode([Hero].self, from: data)
    }
}

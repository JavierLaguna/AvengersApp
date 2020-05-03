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
    
    // TODO: DO ON OTHER THREAD
    private func loadJsonData() {
        do {
            try loadAvengers()
            try loadVillains()
            
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
    
    private func loadVillains() throws {
        guard let pathURL = Bundle.main.url(forResource: "villains_data", withExtension: "json") else {
            return Log.error("Can not find `villains_data` resource")
        }
        
        let data = try Data(contentsOf: pathURL)
        let heroList = try JSONDecoder().decode([Hero].self, from: data)
        
        let villains: [Villain] = heroList.compactMap {
            let villain = villainsRepository.createVillain()
            villain?.name = $0.name
            villain?.image = $0.image
            villain?.power = Int16($0.power)
            villain?.biography = $0.biography
            return villain
        }
        
        villainsRepository.saveVillains(villains)
    }
}

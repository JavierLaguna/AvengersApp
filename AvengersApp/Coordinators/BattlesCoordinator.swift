//
//  BattlesCoordinator.swift
//  AvengersApp
//
//  Created by Javier Laguna on 23/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class BattlesCoordinator: Coordinator {
    
    private let repository: BattlesRepository
    private let avengersRepository: AvengersRepository
    private let villainsRepository: VillainsRepository

    init(repository: BattlesRepository, avengersRepository: AvengersRepository, villainsRepository: VillainsRepository) {
        self.repository = repository
        self.avengersRepository = avengersRepository
        self.villainsRepository = villainsRepository

        super.init()
    }
    
    override func start() {
        presenter.tabBarItem.image = UIImage(imageLiteralResourceName: "ic_tab_battles")
        presenter.tabBarItem.title = "Battles"
        
        let battlesViewModel = BattlesViewModel(repository: repository)
        let battlesViewController = BattlesViewController(viewModel: battlesViewModel)
        
        battlesViewModel.viewDelegate = battlesViewController
        battlesViewModel.coordinatorDelegate = self
        
        presenter.pushViewController(battlesViewController, animated: false)
    }
    
    override func finish() {}
}

// MARK: BattlesCoordinatorDelegate
extension BattlesCoordinator: BattlesCoordinatorDelegate {
    
    func addBattleButtonTapped() {
        let createBattleCoordinator = CreateBattleCoordinator(
            repository: repository,
            avengersRepository: avengersRepository,
            villainsRepository: villainsRepository,
            presenter: presenter)
        
        self.addChildCoordinator(createBattleCoordinator)
        createBattleCoordinator.start()
    }
    
    func didSelect(battle: Battle) {
        print("SELECTED - TODO")
    }
}


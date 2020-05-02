//
//  BattlesCoordinator.swift
//  AvengersApp
//
//  Created by Javier Laguna on 23/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class BattlesCoordinator: Coordinator {
    
    // MARK: Constants
    private let repository: BattlesRepository
    private let avengersRepository: AvengersRepository
    private let villainsRepository: VillainsRepository
    
    // MARK: Variables
    var battlesViewModel: BattlesViewModel?

    // MARK: Lifecycle
    init(repository: BattlesRepository,
         avengersRepository: AvengersRepository,
         villainsRepository: VillainsRepository) {
        
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
        
        self.battlesViewModel = battlesViewModel
        
        presenter.pushViewController(battlesViewController, animated: false)
    }
    
    override func childDidFinish(_ child: Coordinator?) {
        guard let child = child else { return }
        
        if let createBattle = child as? CreateBattleCoordinator {
            if createBattle.createBattleViewModel?.battleResult != nil {
                battlesViewModel?.refreshData()
            }
            
            presenter.dismiss(animated: true, completion: nil)
        }
        
        self.removeChildCoordinator(child)
    }
    
    private func createBattle() {
        let createBattleCoordinator = CreateBattleCoordinator(
            repository: repository,
            avengersRepository: avengersRepository,
            villainsRepository: villainsRepository,
            presenter: presenter)
        
        self.addChildCoordinator(createBattleCoordinator)
        createBattleCoordinator.parentCoordinator = self
        
        createBattleCoordinator.start()
    }
    
    override func finish() { // TODO THIS ON ALL
        self.battlesViewModel = nil
    }
}

// MARK: BattlesCoordinatorDelegate
extension BattlesCoordinator: BattlesCoordinatorDelegate {
    
    func addBattleButtonTapped() {
        createBattle()
    }
    
    func didSelect(battle: Battle) {
        print("SELECTED - TODO")
    }
}


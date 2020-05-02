//
//  CreateBattleCoordinator.swift
//  AvengersApp
//
//  Created by Javier Laguna on 01/05/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class CreateBattleCoordinator: Coordinator {
    
    // MARK: Constants
    private let repository: BattlesRepository
    private let avengersRepository: AvengersRepository
    private let villainsRepository: VillainsRepository
    
    // MARK: Variables
    var createBattleViewModel: CreateBattleViewModel?
    weak var parentCoordinator: Coordinator?
    
    // MARK: Lifecycle
    init(repository: BattlesRepository,
         avengersRepository: AvengersRepository,
         villainsRepository: VillainsRepository,
         presenter: UINavigationController) {
        
        self.repository = repository
        self.avengersRepository = avengersRepository
        self.villainsRepository = villainsRepository
        
        super.init(presenter: presenter)
    }
    
    override func start() {
        let createBattleViewModel = CreateBattleViewModel(repository: repository)
        let createBattleVC = CreateBattleViewController(viewModel: createBattleViewModel)
        
        createBattleViewModel.viewDelegate = createBattleVC
        createBattleViewModel.coordinatorDelegate = self
        
        self.createBattleViewModel = createBattleViewModel
        
        presenter.pushViewController(createBattleVC, animated: true)
    }
    
    override func finish() {
        parentCoordinator?.childDidFinish(self)
    }
}

// MARK: CreateBattleCoordinatorDelegate
extension CreateBattleCoordinator: CreateBattleCoordinatorDelegate {
    
    func addAvengerToBattle() {
        let avengersVM = AvengersViewModel(repository: avengersRepository)
        let avengersVC = AvengersViewController(viewModel: avengersVM)
        
        avengersVM.viewDelegate = avengersVC
        avengersVM.coordinatorDelegate = self
        
        presenter.present(avengersVC, animated: true, completion: nil)
    }
    
    func addVillainToBattle() {
        let villainsVM = VillainsViewModel(repository: villainsRepository)
        let villainsVC = VillainsViewController(viewModel: villainsVM)
        
        villainsVM.viewDelegate = villainsVC
        villainsVM.coordinatorDelegate = self
        
        presenter.present(villainsVC, animated: true, completion: nil)
    }
    
    func viewDidFinish() {
        finish()
    }
}

// MARK: AvengersCoordinatorDelegate
extension CreateBattleCoordinator: AvengersCoordinatorDelegate {
    
    func didSelect(avenger: Avenger) {
        presenter.dismiss(animated: true, completion: nil)
        
        createBattleViewModel?.avengerAdded(avenger)
    }
}

// MARK: VillainsCoordinatorDelegate
extension CreateBattleCoordinator: VillainsCoordinatorDelegate {
    
    func didSelect(villain: Villain) {
        presenter.dismiss(animated: true, completion: nil)
        
        createBattleViewModel?.villainAdded(villain)
    }
}

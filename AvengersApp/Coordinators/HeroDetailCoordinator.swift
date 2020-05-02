//
//  HeroDetailCoordinator.swift
//  AvengersApp
//
//  Created by Javier Laguna on 02/05/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class HeroDetailCoordinator: Coordinator {
    
    // MARK: Constants
    private let avengersRepository: AvengersRepository?
    private let villainsRepository: VillainsRepository?
    private let avenger: Avenger?
    private let villain: Villain?
    private let heroType: HeroType
    
    // MARK: Variables
    var heroDetailViewModel: HeroDetailViewModel?
    weak var parentCoordinator: Coordinator?
    
    // MARK: Lifecycle
    init(avenger: Avenger,
         avengersRepository: AvengersRepository,
         presenter: UINavigationController) {
        
        self.heroType = .avenger
        self.avenger = avenger
        self.avengersRepository = avengersRepository
        
        self.villain = nil
        self.villainsRepository = nil
        
        super.init(presenter: presenter)
    }
    
    init(villain: Villain,
         villainsRepository: VillainsRepository,
         presenter: UINavigationController) {
        
        self.heroType = .villain
        self.villain = villain
        self.villainsRepository = villainsRepository
        
        self.avenger = nil
        self.avengersRepository = nil
        
        super.init(presenter: presenter)
    }
    
    // MARK: Public Functions
    override func start() {
        switch heroType {
        case .avenger:
            startAvengerDetail()
        case .villain:
            startVillainDetail()
        }
    }
    
    private func startAvengerDetail() {
        guard let avenger = avenger, let avengersRepository = avengersRepository else {
            return Log.error("Unexpected avenger or avengersRepository is nil")
        }
        
        let detailViewModel = AvengerDetailViewModel(avenger: avenger, repository: avengersRepository)
        let detailVC = HeroDetailViewController(viewModel: detailViewModel)
        
        // TODO       createBattleViewModel.viewDelegate = createBattleVC
        // TODO       createBattleViewModel.coordinatorDelegate = self
        
        self.heroDetailViewModel = detailViewModel
        
        presenter.pushViewController(detailVC, animated: true)
    }
    
    private func startVillainDetail() {
        guard let villain = villain, let villainsRepository = villainsRepository else {
            return Log.error("Unexpected villain or avengersRepository is nil")
        }
        
        let detailViewModel = VillainDetailViewModel(villain: villain, repository: villainsRepository)
        let detailVC = HeroDetailViewController(viewModel: detailViewModel)
        
        // TODO       createBattleViewModel.viewDelegate = createBattleVC
        // TODO       createBattleViewModel.coordinatorDelegate = self
        
        self.heroDetailViewModel = detailViewModel
        
        presenter.pushViewController(detailVC, animated: true)
    }
    
    override func finish() {
        parentCoordinator?.childDidFinish(self)
    }
}


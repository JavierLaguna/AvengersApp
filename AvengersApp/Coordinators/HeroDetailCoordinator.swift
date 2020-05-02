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
        
        detailViewModel.viewDelegate = detailVC
        detailViewModel.coordinatorDelegate = self
        
        self.heroDetailViewModel = detailViewModel
        
        presenter.pushViewController(detailVC, animated: true)
    }
    
    private func startVillainDetail() {
        guard let villain = villain, let villainsRepository = villainsRepository else {
            return Log.error("Unexpected villain or villainssRepository is nil")
        }
        
        let detailViewModel = VillainDetailViewModel(villain: villain, repository: villainsRepository)
        let detailVC = HeroDetailViewController(viewModel: detailViewModel)
        
        detailViewModel.viewDelegate = detailVC
        detailViewModel.coordinatorDelegate = self
        
        self.heroDetailViewModel = detailViewModel
        
        presenter.pushViewController(detailVC, animated: true)
    }
    
    private func editAvengerPower(avenger: Avenger) {
        guard let avengersRepository = avengersRepository else {
            return Log.error("Unexpected avengersRepository is nil")
        }
        
        let editHeroPowerVM = EditAvengerPowerViewModel(avenger, repository: avengersRepository)
        let editHeroPowerVC = EditHeroPowerViewController(viewModel: editHeroPowerVM)
        
        editHeroPowerVM.coordinatorDelegate = self
        
        presenter.present(editHeroPowerVC, animated: true, completion: nil)
    }
    
    private func editVillainPower(villain: Villain) {
        guard let villainsRepository = villainsRepository else {
            return Log.error("Unexpected villainsRepository is nil")
        }
        
        let editHeroPowerVM = EditVillainPowerViewModel(villain, repository: villainsRepository)
        let editHeroPowerVC = EditHeroPowerViewController(viewModel: editHeroPowerVM)
        
        editHeroPowerVM.coordinatorDelegate = self
        
        presenter.present(editHeroPowerVC, animated: true, completion: nil)
    }
    
    override func finish() {
        parentCoordinator?.childDidFinish(self)
    }
}

// MARK: AvengerDetailCoordinatorDelegate - VillainDetailCoordinatorDelegate
extension HeroDetailCoordinator: AvengerDetailCoordinatorDelegate, VillainDetailCoordinatorDelegate {
    
    func editPower(for avenger: Avenger) {
        editAvengerPower(avenger: avenger)
    }
    
    func editPower(for villain: Villain) {
        editVillainPower(villain: villain)
    }
    
    func viewDidFinish() {
        finish()
    }
}

// MARK: EditHeroPowerCoordinatorDelegate
extension HeroDetailCoordinator: EditHeroPowerCoordinatorDelegate {
    
    func viewDidFinish(powerDidChange: Bool) {
        if powerDidChange {
            heroDetailViewModel?.refreshHero()
        }
        
        presenter.dismiss(animated: true, completion: nil)
    }
}

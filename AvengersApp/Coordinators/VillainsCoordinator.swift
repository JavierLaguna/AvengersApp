//
//  VillainsCoordinator.swift
//  AvengersApp
//
//  Created by Javier Laguna on 23/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class VillainsCoordinator: Coordinator {
    
    // MARK: Constants
    let repository: VillainsRepository
    
    // MARK: Variables
    var villainsViewModel: VillainsViewModel?
    
    // MARK: Lifecycle
    init(repository: VillainsRepository) {
        self.repository = repository
        
        super.init()
    }
    
    override func start() {
        presenter.tabBarItem.image = UIImage(imageLiteralResourceName: "ic_tab_villain")
        presenter.tabBarItem.title = "Villains"
        
        let villainsViewModel = VillainsViewModel(repository: repository)
        let villainsViewController = VillainsViewController(viewModel: villainsViewModel)
        
        villainsViewModel.viewDelegate = villainsViewController
        villainsViewModel.coordinatorDelegate = self
        
        self.villainsViewModel = villainsViewModel
        
        presenter.pushViewController(villainsViewController, animated: false)
    }
    
    override func childDidFinish(_ child: Coordinator?) {
        guard let child = child else { return }
        
        if let villainDetail = child as? HeroDetailCoordinator {
            if villainDetail.heroDetailViewModel?.heroModified ?? false {
                villainsViewModel?.refreshVillains()
            }
            
            presenter.dismiss(animated: true, completion: nil)
        }
        
        self.removeChildCoordinator(child)
    }
    
    private func villainDetail(_ villain: Villain) {
        let detailCoordinator = HeroDetailCoordinator(villain: villain,
                                                      villainsRepository: repository,
                                                      presenter: presenter)
        
        self.addChildCoordinator(detailCoordinator)
        detailCoordinator.parentCoordinator = self
        
        detailCoordinator.start()
    }
    
    override func finish() {
        self.villainsViewModel = nil
    }
}

// MARK: VillainsCoordinatorDelegate
extension VillainsCoordinator: VillainsCoordinatorDelegate {
    
    func didSelect(villain: Villain) {
        villainDetail(villain)
    }
}

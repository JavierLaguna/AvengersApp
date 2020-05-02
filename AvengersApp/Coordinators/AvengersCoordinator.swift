//
//  AvengersCoordinator.swift
//  AvengersApp
//
//  Created by Javier Laguna on 23/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class AvengersCoordinator: Coordinator {
    
    // MARK: Constants
    private let repository: AvengersRepository
    
    // MARK: Variables
    var avengersViewModel: AvengersViewModel?
    
    // MARK: Lifecycle
    init(repository: AvengersRepository) {
        self.repository = repository

        super.init()        
    }

    override func start() {
        presenter.tabBarItem.image = UIImage(imageLiteralResourceName: "ic_tab_heroes")
        presenter.tabBarItem.title = "Avengers"
        
        let avengersViewModel = AvengersViewModel(repository: repository)
        let avengersViewController = AvengersViewController(viewModel: avengersViewModel)
        
        avengersViewModel.viewDelegate = avengersViewController
        avengersViewModel.coordinatorDelegate = self
        
        self.avengersViewModel = avengersViewModel

        presenter.pushViewController(avengersViewController, animated: false)
    }
    
    override func childDidFinish(_ child: Coordinator?) {
        guard let child = child else { return }
        
        if let avengerDetail = child as? HeroDetailCoordinator {
            if avengerDetail.heroDetailViewModel?.heroModified ?? false {
                avengersViewModel?.refreshAvengers()
            }
            
            presenter.dismiss(animated: true, completion: nil)
        }
        
        self.removeChildCoordinator(child)
    }
    
    private func avengerDetail(_ avenger: Avenger) {
        let detailCoordinator = HeroDetailCoordinator(avenger: avenger,
                                                      avengersRepository: repository,
                                                      presenter: presenter)
        
        self.addChildCoordinator(detailCoordinator)
        detailCoordinator.parentCoordinator = self

        detailCoordinator.start()
    }

    override func finish() {
        self.avengersViewModel = nil
    }
}

// MARK: AvengersCoordinatorDelegate
extension AvengersCoordinator: AvengersCoordinatorDelegate {
    
    func didSelect(avenger: Avenger) {
        avengerDetail(avenger)
    }
}

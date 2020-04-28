//
//  AvengersCoordinator.swift
//  AvengersApp
//
//  Created by Javier Laguna on 23/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class AvengersCoordinator: Coordinator {
    
    let repository: AvengersRepository
    
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

        presenter.pushViewController(avengersViewController, animated: false)
    }

    override func finish() {}
}

// MARK: AvengersCoordinatorDelegate
extension AvengersCoordinator: AvengersCoordinatorDelegate{
    func didSelect(avenger: Avenger) {
        
        let detailVC = HeroDetailViewController()
        presenter.pushViewController(detailVC, animated: true)
    }
    
}

//
//  AvengersCoordinator.swift
//  AvengersApp
//
//  Created by Javier Laguna on 23/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class AvengersCoordinator: Coordinator {
    
    override func start() {
        presenter.tabBarItem.image = UIImage(imageLiteralResourceName: "ic_tab_heroes")
        presenter.tabBarItem.title = "Avengers"
        
        let avengersViewController = AvengersViewController()
        presenter.pushViewController(avengersViewController, animated: false)
    }

    override func finish() {}
}

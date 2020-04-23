//
//  BattlesCoordinator.swift
//  AvengersApp
//
//  Created by Javier Laguna on 23/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class BattlesCoordinator: Coordinator {
    
    override func start() {
        presenter.tabBarItem.image = UIImage(imageLiteralResourceName: "ic_tab_battles")
        presenter.tabBarItem.title = "Battles"
        
        let battlesViewController = BattlesViewController()
        presenter.pushViewController(battlesViewController, animated: false)
    }

    override func finish() {}
}

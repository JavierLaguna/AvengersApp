//
//  VillainsCoordinator.swift
//  AvengersApp
//
//  Created by Javier Laguna on 23/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class VillainsCoordinator: Coordinator {
    
    let repository: VillainsRepository
    
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
        
        presenter.pushViewController(villainsViewController, animated: false)
    }
    
    override func finish() {}
}

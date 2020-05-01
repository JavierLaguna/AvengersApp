//
//  BattleCellViewModel.swift
//  AvengersApp
//
//  Created by Javier Laguna on 01/05/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation
import UIKit

struct BattleCellViewModel {
    
    let battle: Battle
    
    let battleTitle: String
    let avengerImage: UIImage?
    let villainImage: UIImage?
    
    init(_ battle: Battle) {
        self.battle = battle
        
        self.battleTitle = "Batalla \(battle.number)"
        self.avengerImage = UIImage(imageLiteralResourceName: battle.avenger?.image ?? "")
        self.villainImage = UIImage(imageLiteralResourceName: battle.villain?.image ?? "")
    }
}
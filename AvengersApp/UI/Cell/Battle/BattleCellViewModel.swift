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
    
    // MARK: Constants
    let battle: Battle
    let battleTitle: String
    let avengerImage: UIImage?
    let villainImage: UIImage?
    let battleWinner: BattleResult?
    
    // MARK: Lifecycle
    init(_ battle: Battle) {
        self.battle = battle
        
        self.battleTitle = "Batalla \(battle.number)"
        self.avengerImage = UIImage(imageLiteralResourceName: battle.avenger?.image ?? "")
        self.villainImage = UIImage(imageLiteralResourceName: battle.villain?.image ?? "")
        self.battleWinner = BattleResult(rawValue: Int(battle.winner))
    }
}

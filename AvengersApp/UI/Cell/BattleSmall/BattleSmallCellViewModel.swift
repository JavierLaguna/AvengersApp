//
//  BattleSmallCellViewModel.swift
//  AvengersApp
//
//  Created by Javier Laguna on 02/05/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

struct BattleSmallCellViewModel {
    
    // MARK: Constants
    let battle: Battle
    let battleTitle: String
    let winner: BattleResult?
    
    // MARK: Lifecycle
    init(_ battle: Battle) {
        self.battle = battle
        
        self.battleTitle = "Batalla \(battle.number)"
        self.winner = BattleResult(rawValue: Int(battle.winner))
    }
}

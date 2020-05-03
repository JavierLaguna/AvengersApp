//
//  BattleDetailViewModel.swift
//  AvengersApp
//
//  Created by Javier Laguna on 03/05/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

protocol BattleDetailCoordinatorDelegate: class {
    func battleDeleted()
}

class BattleDetailViewModel {
    
    // MARK: Constants
    private let repository: BattlesRepository
    private let battle: Battle
    let battleTitle: String
    let battleResult: BattleResult?
    let avengerImage: UIImage?
    let villainImage: UIImage?
    
    // MARK: Variables
    weak var coordinatorDelegate: BattleDetailCoordinatorDelegate?
//    weak var viewDelegate: CreateBattleViewDelegate?
    
    // MARK: Lifecycle
    init(battle: Battle, repository: BattlesRepository) {
        self.battle = battle
        self.repository = repository
        
        self.battleTitle = "Batalla \(battle.number)"
        self.battleResult = BattleResult.init(rawValue: Int(battle.winner))
        self.avengerImage = UIImage(imageLiteralResourceName: battle.avenger?.image ?? "")
        self.villainImage = UIImage(imageLiteralResourceName: battle.villain?.image ?? "")
    }
    
    // MARK: Public Functions
    func deleteBattle() {
        repository.deleteBattle(battle)
        coordinatorDelegate?.battleDeleted()
    }
}

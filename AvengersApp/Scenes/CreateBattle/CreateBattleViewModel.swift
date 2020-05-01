//
//  CreateBattleViewModel.swift
//  AvengersApp
//
//  Created by Javier Laguna on 01/05/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

protocol CreateBattleCoordinatorDelegate: class {
    func addAvengerToBattle()
    func addVillainToBattle()
}

protocol CreateBattleViewDelegate: class {
    func avengerDidAdded(_ avenger: Avenger)
    func villainDidAdded(_ villain: Villain)
}

class CreateBattleViewModel {
    weak var coordinatorDelegate: CreateBattleCoordinatorDelegate?
    weak var viewDelegate: CreateBattleViewDelegate?
    let repository: BattlesRepository
    var battles: Battle?
    var avenger: Avenger?
    var villain: Villain?
    var battleResult: BattleResult?
    
    init(repository: BattlesRepository) {
        self.repository = repository
    }
    
    func addAvenger() {
        coordinatorDelegate?.addAvengerToBattle()
    }
    
    func avengerAdded(_ avenger: Avenger) {
        self.avenger = avenger
        viewDelegate?.avengerDidAdded(avenger)
    }
    
    func addVillain() {
        coordinatorDelegate?.addVillainToBattle()
    }
    
    func villainAdded(_ villain: Villain) {
        self.villain = villain
        viewDelegate?.villainDidAdded(villain)
    }
}

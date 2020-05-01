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
    func errorCreatingBattle(_ errorMsg: String)
    func battleFinish(_ battle: Battle, with result: BattleResult)
}

class CreateBattleViewModel {

    // MARK: Constants
    private let repository: BattlesRepository

    // MARK: Variables
    private var battle: Battle?
    private var avenger: Avenger?
    private var villain: Villain?
    private var battleResult: BattleResult?
    
    weak var coordinatorDelegate: CreateBattleCoordinatorDelegate?
    weak var viewDelegate: CreateBattleViewDelegate?
     
    // MARK: Lifecycle
    init(repository: BattlesRepository) {
        self.repository = repository
    }
    
    // MARK: Public Functions
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
    
    func startBattle() {
        guard let avenger = avenger else {
            viewDelegate?.errorCreatingBattle("Antes tienes que seleccionar un Avenger!")
            return
        }
        guard let villain = villain else {
            viewDelegate?.errorCreatingBattle("Antes tienes que seleccionar un Villain!")
            return
        }
        
        guard let battle = repository.createBattle() else {
            Log.error("Error creating new Battle")
            viewDelegate?.errorCreatingBattle("Algo insesperado ha sucedido! Prueba de nuevo en unos segundos!")
            return
        }
        
        battle.number = 0 // TODO
        battle.avenger = avenger
        battle.villain = villain
        
        let result = getWinner(avenger: avenger, villain: villain)
        battle.winner = Int16(result.rawValue)
        
        self.battleResult = result
        self.battle = battle
        
        repository.saveBattle(battle)
        viewDelegate?.battleFinish(battle, with: result)
    }
    
    // MARK: Private Functions
    private func getWinner(avenger: Avenger, villain: Villain) -> BattleResult {
        let avengerPower = Int(avenger.power)
        let villainPower = Int(villain.power)

        let differencePower = avengerPower - villainPower
        let number = Int.random(in: 0 ..< 11) - differencePower
        
        if number < 6 {
            return .avengerWins
        }
        return .villainWins
    }
}

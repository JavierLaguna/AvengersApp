//
//  BattlesRepositoryCoreData.swift
//  AvengersApp
//
//  Created by Javier Laguna on 01/05/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

struct BattlesRepositoryCoreData: CoreDataRepository, BattlesRepository {
    
    // MARK: CoreDataRepository
    var database = CoreDataDatabase()
    var entityName: String { "Battle" }
    
    // MARK: BattlesRepository
    func fetchAllBattles() -> [Battle] {
        return database.fetchAllData(for: entityName) as? [Battle] ?? []
    }
    
    func fetchLastBattle() -> Battle? {
        // TODO
        return nil
    }
    
    func createBattle() -> Battle? {
        return database.createData(for: entityName) as? Battle
    }
    
    func saveBattle(_ battle: Battle) {
        database.persistAllData()
    }
    
    func saveBattles(_ battles: [Battle]) {
        database.persistAllData()
    }
    
    func deleteBattle(_ battle: Battle) {
        database.delete(data: [battle])
    }
    
    func deleteAllBattles(_ battles: [Battle]) {
        database.delete(data: battles)
    }
}

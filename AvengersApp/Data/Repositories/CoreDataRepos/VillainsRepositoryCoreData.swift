//
//  VillainsRepositoryCoreData.swift
//  AvengersApp
//
//  Created by Javier Laguna on 28/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

struct VillainsRepositoryCoreData: CoreDataRepository, VillainsRepository {
    
    // MARK: CoreDataRepository
    var database = CoreDataDatabase()
    var entityName: String { "Villain" }
    
    // MARK: VillainsRepository
    func fetchAllVillains() -> [Villain] {
        return database.fetchAllData(for: entityName) as? [Villain] ?? []
    }
    
    func createVillain() -> Villain? {
        return database.createData(for: entityName) as? Villain
    }
    
    func saveVillain(_ villain: Villain) {
        database.persistAllData()
    }
    
    func saveVillains(_ villains: [Villain]) {
        database.persistAllData()
    }
    
    func deleteVillain(_ villain: Villain) {
        database.delete(data: [villain])
    }
    
    func deleteAllVillains(_ villains: [Villain]) {
        database.delete(data: villains)
        
    }
}

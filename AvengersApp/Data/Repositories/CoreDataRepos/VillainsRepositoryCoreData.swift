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
    let database: CoreDataDatabase
    var entityName: String { "Villain" }
    let entityNameKey: String = "name"
    
    // MARK: VillainsRepository
    func createVillain() -> Villain? {
        return database.createData(for: entityName) as? Villain
    }
    
    func createVillain(from heroList: [Hero]) -> [Villain] {
        let villains: [Villain] = heroList.compactMap {
            let villain = createVillain()
            villain?.name = $0.name
            villain?.image = $0.image
            villain?.power = Int16($0.power)
            villain?.biography = $0.biography
            return villain
        }
        
        saveVillains(villains)
        
        return villains
    }
    
    func fetchAllVillains() -> [Villain] {
        return database.fetchAllData(for: entityName) as? [Villain] ?? []
    }
    
    func fetchVillainBy(name: String) -> Villain? {
        let predicate = NSPredicate(format: "\(entityNameKey) = %@", name)
        let fetchLimit = 1
        
        return database.fetchDataBy(predicate: predicate, fetchLimit: fetchLimit, for: entityName)?.first as? Villain
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

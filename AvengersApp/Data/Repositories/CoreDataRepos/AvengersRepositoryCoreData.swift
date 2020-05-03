//
//  AvengersRepository+CoreData.swift
//  AvengersApp
//
//  Created by Javier Laguna on 27/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import Foundation

struct AvengersRepositoryCoreData: CoreDataRepository, AvengersRepository {
    
    // MARK: Co[Hero]reDataRepository
    let database: CoreDataDatabase
    var entityName: String { "Avenger" }
    let entityNameKey: String = "name"
    
    // MARK: AvengersRepository
    func createAvenger() -> Avenger? {
        return database.createData(for: entityName) as? Avenger
    }
    
    func createAvengers(from heroList: [Hero]) -> [Avenger] {
        let avengers: [Avenger] = heroList.compactMap {
            let avenger = createAvenger()
            avenger?.name = $0.name
            avenger?.image = $0.image
            avenger?.power = Int16($0.power)
            avenger?.biography = $0.biography
            return avenger
        }

        saveAvengers(avengers)

        return avengers
    }
    
    func fetchAllAvengers() -> [Avenger] {
        return database.fetchAllData(for: entityName) as? [Avenger] ?? []
    }
    
    func fetchAvengerBy(name: String) -> Avenger? {
        let predicate = NSPredicate(format: "\(entityNameKey) = %@", name)
        let fetchLimit = 1
        
        return database.fetchDataBy(predicate: predicate, fetchLimit: fetchLimit, for: entityName)?.first as? Avenger
    }
    
    func saveAvenger(_ avenger: Avenger) {
        database.persistAllData()
    }
    
    func saveAvengers(_ avengers: [Avenger]) {
        database.persistAllData()
    }
    
    func deleteAvenger(_ avenger: Avenger) {
        database.delete(data: [avenger])
    }
    
    func deleteAllAvengers(_ avengers: [Avenger]) {
        database.delete(data: avengers)
    }
}

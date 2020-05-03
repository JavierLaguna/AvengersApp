//
//  CoreDataDatabase.swift
//  AvengersApp
//
//  Created by Javier Laguna on 27/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit
import CoreData

class CoreDataDatabase {
    
    // MARK: Persistent Container
    private func persistentContainer() -> NSPersistentContainer? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        return appDelegate.persistentContainer
    }
    
    // MARK: Managed Object Context
    private func context() -> NSManagedObjectContext? {
        guard let persistentContainer = persistentContainer() else {
            return nil
        }
        
        return persistentContainer.viewContext
    }
    
    // MARK: Background Thread - Managed Object Context
    lazy var backgroundContext: NSManagedObjectContext? = {
        guard let persistentContainer = persistentContainer() else {
            return nil
        }
        
        let newbackgroundContext = persistentContainer.newBackgroundContext()
        newbackgroundContext.automaticallyMergesChangesFromParent = true
        return newbackgroundContext
    }()
    
    // MARK: Database methods
    func createData(for entityName: String) -> NSManagedObject? {
        guard let backgroundContext = backgroundContext,
            let entity = NSEntityDescription.entity(forEntityName: entityName, in: backgroundContext) else {
                return nil
        }
        
        return NSManagedObject(entity: entity, insertInto: backgroundContext)
    }
    
    func fetchAllData(for entityName: String) -> [NSManagedObject]? {
        return try? backgroundContext?.fetch(NSFetchRequest<NSFetchRequestResult>(entityName: entityName)) as? [NSManagedObject]
    }
    
    func fetchDataBy(predicate: NSPredicate? = nil,
                     sortDescriptors: [NSSortDescriptor]? = nil,
                     fetchLimit: Int? = nil,
                     for entityName: String) -> [NSManagedObject]? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        if let fetchLimit = fetchLimit {
            fetchRequest.fetchLimit = fetchLimit
        }
        
        return try? backgroundContext?.fetch(fetchRequest) as? [NSManagedObject]
    }
    
    func persistAllData() {
        guard let backgroundContext = backgroundContext else { return }
        
        backgroundContext.performAndWait {
            try? backgroundContext.save()
        }
    }
    
    func delete(data: [NSManagedObject]) {
        guard let backgroundContext = backgroundContext else { return }
        
        backgroundContext.performAndWait {
            data.forEach {
                backgroundContext.delete($0)
            }
            
            try? backgroundContext.save()
        }
    }
}

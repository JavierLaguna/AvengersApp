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
    
    // MARK: Managed Object Context
    private func context() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK: Database methods
    func createData(for entityName: String) -> NSManagedObject? {
        guard let context = context(),
            let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
                return nil
        }
        
        return NSManagedObject(entity: entity, insertInto: context)
    }
    
    func persistAllData() {
        try? context()?.save()
    }
    
    func fetchAllData(for entityName: String) -> [NSManagedObject]? {
        return try? context()?.fetch(NSFetchRequest<NSFetchRequestResult>(entityName: entityName)) as? [NSManagedObject]
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
        
        return try? context()?.fetch(fetchRequest) as? [NSManagedObject]
    }
    
    func delete(data: [NSManagedObject]) {
        guard let context = context() else { return }
        
        data.forEach {
            context.delete($0)
        }
        
        try? context.save()
    }
}

//
//  File.swift
//  HW4
//
//  Created by Ян Козыренко on 10.07.2023.
//

import CoreData

class Container: NSPersistentContainer {
    
    static let shared: Container = {
        let c = Container(name: "Model")
        c.loadPersistentStores { _, error in
            if let error {
                print(error)
            }
        }
        c.viewContext.automaticallyMergesChangesFromParent = true
        return c
    }()
    
    func saveContext(backgroundContext: NSManagedObjectContext? = nil) {
        let context = backgroundContext ?? viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

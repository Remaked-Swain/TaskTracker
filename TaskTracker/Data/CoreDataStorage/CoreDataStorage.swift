//
//  CoreDataStorage.swift
//  TaskTracker
//
//  Created by Swain Yun on 3/30/24.
//

import CoreData

enum CoreDataStorageError: Error {
    case readFailed(Error)
    case saveFailed(Error)
    case deleteFailed(Error)
}

final class CoreDataStorage {
    static let shared = CoreDataStorage()
    
    private lazy var persistanceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataStorage")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                assertionFailure("CoreDataStorage Unresolved Error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: Public Methods
    func saveContext()  {
        let context = persistanceContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                assertionFailure("CoreDataStorage Unresolved Error \(error)")
            }
        }
    }
}

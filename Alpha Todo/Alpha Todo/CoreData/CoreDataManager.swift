//
//  CoreDataManager.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 30/12/23.
//

import CoreData

struct CoreDataManager {

    static let shared = CoreDataManager()

    private init() {}
    
    let persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: AppDelegate.appName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of data store failed: \(error)")
            }
        }

        return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    @discardableResult
    func createAlphaTask(_ task: AlphaTask) -> AlphaTask? {
        let context = persistentContainer.viewContext
        
        // old way
        // let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee // NSManagedObject
        
        // new way
        let newTask = AlphaTask(context: context)
        newTask.name = task.name
        newTask.imageName = task.imageName
        newTask.isSelected = task.isSelected
        newTask.todos = task.todos
        
        do {
            try context.save()
            return newTask
        } catch let error {
            print("Failed to create: \(error)")
        }

        return nil
    }

    func fetchAlphaTasks() -> [AlphaTask]? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<AlphaTask>(entityName: AlphaTask.entityName)

        do {
            let tasks = try context.fetch(fetchRequest)
            return tasks
        } catch let error {
            print("Failed to fetch Alpha Tasks: \(error)")
        }

        return nil
    }

    func fetchAlphaTask(withName name: String) -> AlphaTask? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<AlphaTask>(entityName: AlphaTask.entityName)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do {
            let tasks = try context.fetch(fetchRequest)
            return tasks.first
        } catch let error {
            print("Failed to fetch: \(error)")
        }

        return nil
    }

    func updateAlphaTask(with task: AlphaTask) {
        let context = persistentContainer.viewContext

        do {
            try context.save()
        } catch let error {
            print("Failed to update Alpha Task: \(error)")
        }
    }

    func deleteAlphaTask(_ task: AlphaTask) {
        let context = persistentContainer.viewContext
        context.delete(task)

        do {
            try context.save()
        } catch let error {
            print("Failed to delete Alpha Task: \(error)")
        }
    }

}

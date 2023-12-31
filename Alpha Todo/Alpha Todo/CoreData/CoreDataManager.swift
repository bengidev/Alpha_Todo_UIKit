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
    func createCDAlphaTask(_ task: AlphaTask) -> CDAlphaTask? {
        let context = persistentContainer.viewContext
        
        // old way
        // let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee // NSManagedObject
        
        // new way

        let newTask = self.convertAlphaTaskIntoCDAlphaTask(task)
        print("Core Data Manager New Task: \(newTask)")
        print("Core Data Manager Todos Count: \(task.todos.count)")
        
        do {
            try context.save()
            return newTask
        } catch let error {
            print("Failed to create: \(error)")
        }

        return nil
    }

    @discardableResult
    func fetchCDAlphaTasks() -> [CDAlphaTask]? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<CDAlphaTask>(entityName: CDAlphaTask.entityName)

        do {
            let tasks = try context.fetch(fetchRequest)
            return tasks
        } catch let error {
            print("Failed to fetch CDAlphaTasks: \(error)")
        }

        return nil
    }

    func fetchCDAlphaTask(withName name: String) -> CDAlphaTask? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<CDAlphaTask>(entityName: CDAlphaTask.entityName)
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

    func updateCDAlphaTask(with task: AlphaTask) {
        let context = persistentContainer.viewContext

        let willUpdateTask = self.convertAlphaTaskIntoCDAlphaTask(task, withFetch: true)
        print("Core Data Manager Update Task: \(String(describing: willUpdateTask))")
        
        do {
            try context.save()
        } catch let error {
            print("Failed to update Alpha Task: \(error)")
        }
    }

    func deleteCDAlphaTask(_ task: AlphaTask) {
        let context = persistentContainer.viewContext
        
        let willDeleteTask = self.fetchCDAlphaTask(withName: task.name) ?? .init(context: context)
        
        print("Core Data Manager Delete Task: \(String(describing: willDeleteTask))")
        
        context.delete(willDeleteTask)

        do {
            try context.save()
        } catch let error {
            print("Failed to delete CDAlphaTask: \(error)")
        }
    }

    func convertAlphaTaskIntoCDAlphaTask(_ task: AlphaTask, withFetch: Bool = false) -> CDAlphaTask {
        let context = persistentContainer.viewContext

        // Map Todo into CDTodo for inserting into CDAlphaTodo
        let convertedTodos = task.todos.map({
            var cdTodo = CDTodo(context: context)
            cdTodo.title = $0.title
            cdTodo.dueDate = $0.dueDate
            cdTodo.descriptions = $0.descriptions
            cdTodo.isImportant = $0.isImportant
            cdTodo.isCompleted = $0.isCompleted
            
            return cdTodo
        })
        
        // Fetch CDAlphaTask if withFetch was true,
        // otherwise create new CDAlphaTask.
        //
        // Append CDTodo from convertedTodos into CDAlphaTask when withFetch was true
        // otherwise, create new CDTodo NSSet from convertedTodos.
        let convertedTask: CDAlphaTask
        if withFetch {
            convertedTask = self.fetchCDAlphaTask(withName: task.name) ?? .init(context: context)
            for todo in convertedTodos {
                convertedTask.addToTodos(todo)
            }
        } else {
            convertedTask = .init(context: context)
            convertedTask.todos = .init(array: convertedTodos)
        }
        
        // Assign AlphaTask properties into CDAlphaTask
        convertedTask.name = task.name
        convertedTask.imageName = task.imageName
        convertedTask.isSelected = task.isSelected
        
        return convertedTask
    }
}

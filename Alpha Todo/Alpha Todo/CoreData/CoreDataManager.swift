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
        
        // Map Todo into CDTodo for inserting into CDAlphaTodo
        let convertedTodos = task.todos.map({
            let cdTodo = CDTodo(context: context)
            cdTodo.uuid = $0.id
            cdTodo.title = $0.title
            cdTodo.dueDate = $0.dueDate
            cdTodo.descriptions = $0.descriptions
            cdTodo.isImportant = $0.isImportant
            cdTodo.isCompleted = $0.isCompleted
            
            return cdTodo
        })
        
        // old way
        // let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee // NSManagedObject
        
        // new way
        let newTask: CDAlphaTask = .init(context: context)
        newTask.uuid = .init()
        newTask.todos = .init(array: convertedTodos)
        newTask.name = task.name
        newTask.imageName = task.imageName
        newTask.isSelected = task.isSelected
        
        print("Core Data Manager New Task: \(newTask.wrappedName)")
        print("Core Data Manager New Task: \(newTask.wrappedUUID)")
        
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
    
    @discardableResult
    func fetchCDAlphaTasks(with task: CDAlphaTask) -> [CDAlphaTask]? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<CDAlphaTask>(entityName: CDAlphaTask.entityName)
        fetchRequest.predicate = NSPredicate(format: "%K == %@", "name", task.wrappedName)

        do {
            let tasks = try context.fetch(fetchRequest)
            return tasks
        } catch let error {
            print("Failed to fetch CDAlphaTasks: \(error)")
        }

        return nil
    }

    func fetchCDAlphaTask(withUUID uuid: UUID) -> CDAlphaTask? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<CDAlphaTask>(entityName: CDAlphaTask.entityName)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "%K == %@", "uuid", uuid as CVarArg)

        do {
            let tasks = try context.fetch(fetchRequest)
            
            print("Fetch Results: \(tasks)")
            
            return tasks.first
        } catch let error {
            print("Failed to fetch: \(error)")
        }

        return nil
    }

    func updateCDAlphaTask(uuid: UUID, with task: AlphaTask) {
        let context = persistentContainer.viewContext

        let willUpdateTask = self.fetchCDAlphaTask(withUUID: uuid)
        
        // Map Todo into CDTodo for inserting into CDAlphaTodo
        let convertedTodos = task.todos.map({
            let cdTodo = CDTodo(context: context)
            cdTodo.uuid = .init()
            cdTodo.title = $0.title
            cdTodo.dueDate = $0.dueDate
            cdTodo.descriptions = $0.descriptions
            cdTodo.isImportant = $0.isImportant
            cdTodo.isCompleted = $0.isCompleted
            
            return cdTodo
        })
        
        for todo in convertedTodos {
            willUpdateTask?.addToTodos(todo)
        }
        
        print("Core Data Manager Update Task: \(String(describing: willUpdateTask?.wrappedName))")
        
        do {
            try context.save()
        } catch let error {
            print("Failed to update Alpha Task: \(error)")
        }
    }

    func deleteCDAlphaTask(_ task: AlphaTask) {
        let context = persistentContainer.viewContext
        
        let willDeleteTask = self.fetchCDAlphaTask(withUUID: task.id) ?? .init(context: context)
        
        print("Core Data Manager Delete Task: \(String(describing: willDeleteTask))")
        
        context.delete(willDeleteTask)
        do {
            try context.save()
        } catch let error {
            print("Failed to delete CDAlphaTask: \(error)")
        }
    }
    
    func swapCDTodo(_ task: CDAlphaTask, from fromIndex: IndexPath, to toIndex: IndexPath) -> Void {
        let itemWillMove = task.wrappedTodos[fromIndex.row]
        task.removeFromTodos(at: fromIndex.row)
        task.insertIntoTodos(itemWillMove, at: toIndex.row)
        
        print("Core Data Manager Swap CDTodo: \(String(describing: itemWillMove))")
        
        do {
            try context.save()
        } catch let error {
            print("Failed to delete CDAlphaTask: \(error)")
        }
    }
    
    func deleteCDTodo(from task: CDAlphaTask, with indexPath: IndexPath) {
        let context = persistentContainer.viewContext
        
        let willDeleteTodo = task.wrappedTodos[indexPath.row]
        task.removeFromTodos(willDeleteTodo)
        
        print("Core Data Manager Delete Todo: \(String(describing: willDeleteTodo))")
        do {
            try context.save()
        } catch let error {
            print("Failed to delete CDAlphaTask: \(error)")
        }
    }
}

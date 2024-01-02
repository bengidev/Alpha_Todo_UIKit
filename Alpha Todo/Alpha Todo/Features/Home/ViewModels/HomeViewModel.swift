//
//  HomeViewModel.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 21/12/23.
//

import CoreData
import Foundation

@MainActor
final class HomeViewModel {
    private let coreDataManager = CoreDataManager.shared
    private(set) var tasks: [CDAlphaTask] = []
    
    init() {
        self.fetchTasks()
        print("Fetched Tasks: \(tasks.count)")
    }

    var getContext: NSManagedObjectContext {
        return self.coreDataManager.context
    }
    
    func fetchTasks() -> Void {
        self.tasks = self.coreDataManager.fetchCDAlphaTasks() ?? []
    }
    
    func fetchTask(withUUID uuid: UUID) -> Void {
        let task = self.coreDataManager.fetchCDAlphaTask(withUUID: uuid)
        print("HomeViewModel fetchTask: \(String(describing: task?.wrappedName))")
    }
    
    func addNewTask(_ task: AlphaTask) -> Void {
        self.coreDataManager.createCDAlphaTask(task)
    }
    
    func updateCurrentTask(uuid: UUID, with task: AlphaTask) -> Void {
        self.coreDataManager.updateCDAlphaTask(uuid: uuid, with: task)
    }
    
    func swapTodo(from task: CDAlphaTask, from fromIndex: IndexPath, to toIndex: IndexPath) -> Void {
        self.coreDataManager.swapCDTodo(task, from: fromIndex, to: toIndex)
    }
    
    func removeTodo(from task: CDAlphaTask, with indexPath: IndexPath) -> Void {
        self.coreDataManager.deleteCDTodo(from: task, with: indexPath)
    }
}

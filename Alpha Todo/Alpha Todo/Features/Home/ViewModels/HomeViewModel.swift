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
    
    func addNewTask(_ task: AlphaTask) -> Void {
        self.coreDataManager.createCDAlphaTask(task)
    }
    
    func updateCurrentTask(with task: AlphaTask) -> Void {
        self.coreDataManager.updateCDAlphaTask(with: task)
    }
}

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
    private(set) var tasks: [AlphaTask] = []
    
    init() {
        self.tasks = self.coreDataManager.fetchAlphaTasks() ?? []
        print("Fetched Tasks: \(tasks.count)")
    }

    var getContext: NSManagedObjectContext {
        return self.coreDataManager.context
    }
    
    func updateCurrentTask(with task: AlphaTask) -> Void {
        self.coreDataManager.updateAlphaTask(with: task)
    }
}

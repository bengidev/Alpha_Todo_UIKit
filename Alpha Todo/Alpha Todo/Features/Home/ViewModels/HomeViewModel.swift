//
//  HomeViewModel.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 21/12/23.
//

import Foundation

@MainActor
final class HomeViewModel {
    private(set) var tasks: [Task] = []
    
    func addNewTask(_ task: Task) -> Void {
        self.tasks.append(task)
    }
    
    func updateCurrentTask(for indexPath: IndexPath, with todos: [Todo]) -> Void {
        for todo in todos {
            self.tasks[indexPath.row].addNewTodo(todo)
        }
        
    }
}

//
//  Task.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 24/12/23.
//

import Foundation

struct Task: Hashable, Identifiable {
    let id = UUID()
    var category: Category
    var todos: [Todo]
    
    static let empty: Task = .init(category: .empty, todos: [.empty])
    
    mutating func addNewTodo(_ todo: Todo) -> Void {
        self.todos.append(todo)
    }
}

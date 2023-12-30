//
//  Todo.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 24/12/23.
//

import Foundation

struct Todo: Hashable, Identifiable {
    let id = UUID()
    var title: String
    var dueDate: Date
    var description: String
    var isImportant: Bool
    var hasCompleted: Bool
    
    static let empty: Todo = .init(
        title: "",
        dueDate: .init(),
        description: "",
        isImportant: false,
        hasCompleted: false
    )
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy 'at' hh:mm a"
        formatter.locale = .current
        
        return formatter.string(from: self.dueDate)
    }
    
    mutating func change(to newTodo: Todo) -> Void {
        self = newTodo
    }
}



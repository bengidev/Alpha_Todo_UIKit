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
    var timeStart: Date
    var timeEnd: Date
    var description: String
    var isImportant: Bool
    var hasCompleted: Bool
    
    static let empty: Todo = .init(
        title: "",
        timeStart: .init(),
        timeEnd: .init(),
        description: "",
        isImportant: false,
        hasCompleted: false
    )
    
    mutating func change(to newTodo: Todo) -> Void {
        self = newTodo
    }
}



//
//  Todo.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 31/12/23.
//

import Foundation

struct Todo: Hashable, Identifiable {
    let id = UUID()
    var title: String
    var dueDate: Date
    var descriptions: String
    var isImportant: Bool
    var isCompleted: Bool
    
    static let empty: Todo = .init(
        title: "",
        dueDate: .init(),
        descriptions: "",
        isImportant: false,
        isCompleted: false
    )
}

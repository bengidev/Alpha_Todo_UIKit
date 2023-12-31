//
//  AlphaTask.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 31/12/23.
//

import Foundation

struct AlphaTask: Hashable, Identifiable {
    let id = UUID()
    var name: String
    var imageName: String
    var isSelected: Bool
    var todos: [Todo]
    
    static let empty: AlphaTask = .init(
        name: "",
        imageName: "",
        isSelected: false,
        todos: [.empty]
    )
}

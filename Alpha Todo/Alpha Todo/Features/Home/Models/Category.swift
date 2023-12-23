//
//  Category.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 21/12/23.
//

import UIKit

struct Category: Hashable, Identifiable {
    let id = UUID()
    var name: String
    var imageName: String
    var isSelected: Bool
    
    static let empty: Category = .init(name: "", imageName: "", isSelected: false)
    
    mutating func change(to newCategory: Category) -> Void {
        self = newCategory
    }
    
    mutating func changeName(_ name: String) -> Void {
        self.name = name
    }
    
    mutating func changeImageName(_ imageName: String) -> Void {
        self.imageName = imageName
    }
    
    mutating func toggleIsSelected() -> Void {
        self.isSelected.toggle()
    }
}

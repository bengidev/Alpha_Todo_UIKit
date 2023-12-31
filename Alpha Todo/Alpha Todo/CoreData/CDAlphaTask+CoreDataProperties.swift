//
//  CDAlphaTask+CoreDataProperties.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 31/12/23.
//
//

import Foundation
import CoreData


extension CDAlphaTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAlphaTask> {
        return NSFetchRequest<CDAlphaTask>(entityName: "CDAlphaTask")
    }

    @NSManaged public var imageName: String?
    @NSManaged public var isSelected: Bool
    @NSManaged public var name: String?
    @NSManaged public var todos: NSSet?

    var wrappedName: String {
        return self.name ?? ""
    }
    
    var wrappedImageName: String {
        return self.imageName ?? ""
    }
    
    var wrappedIsSelected: Bool {
        return self.isSelected
    }
    
    var wrappedTodos: [CDTodo] {
        return self.todos?.allObjects as? [CDTodo] ?? []
    }
    
}

// MARK: Generated accessors for todos
extension CDAlphaTask {

    @objc(addTodosObject:)
    @NSManaged public func addToTodos(_ value: CDTodo)

    @objc(removeTodosObject:)
    @NSManaged public func removeFromTodos(_ value: CDTodo)

    @objc(addTodos:)
    @NSManaged public func addToTodos(_ values: NSSet)

    @objc(removeTodos:)
    @NSManaged public func removeFromTodos(_ values: NSSet)

}

extension CDAlphaTask : Identifiable {

}

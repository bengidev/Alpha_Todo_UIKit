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
    @NSManaged public var uuid: UUID?
    @NSManaged public var todos: NSOrderedSet?

    var wrappedUUID: UUID {
        return self.uuid ?? .init()
    }
    
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
        return (self.todos?.array as? [CDTodo]) ?? []
    }
}

// MARK: Generated accessors for todos
extension CDAlphaTask {

    @objc(insertObject:inTodosAtIndex:)
    @NSManaged public func insertIntoTodos(_ value: CDTodo, at idx: Int)

    @objc(removeObjectFromTodosAtIndex:)
    @NSManaged public func removeFromTodos(at idx: Int)

    @objc(insertTodos:atIndexes:)
    @NSManaged public func insertIntoTodos(_ values: [CDTodo], at indexes: NSIndexSet)

    @objc(removeTodosAtIndexes:)
    @NSManaged public func removeFromTodos(at indexes: NSIndexSet)

    @objc(replaceObjectInTodosAtIndex:withObject:)
    @NSManaged public func replaceTodos(at idx: Int, with value: CDTodo)

    @objc(replaceTodosAtIndexes:withTodos:)
    @NSManaged public func replaceTodos(at indexes: NSIndexSet, with values: [CDTodo])

    @objc(addTodosObject:)
    @NSManaged public func addToTodos(_ value: CDTodo)

    @objc(removeTodosObject:)
    @NSManaged public func removeFromTodos(_ value: CDTodo)

    @objc(addTodos:)
    @NSManaged public func addToTodos(_ values: NSOrderedSet)

    @objc(removeTodos:)
    @NSManaged public func removeFromTodos(_ values: NSOrderedSet)

}

extension CDAlphaTask : Identifiable { }

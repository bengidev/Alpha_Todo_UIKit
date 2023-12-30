//
//  AlphaTask+CoreDataProperties.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 30/12/23.
//
//

import Foundation
import CoreData


extension AlphaTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlphaTask> {
        return NSFetchRequest<AlphaTask>(entityName: "AlphaTask")
    }

    @NSManaged public var name: String?
    @NSManaged public var imageName: String?
    @NSManaged public var isSelected: Bool
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
    
    var wrappedTodos: [Todo] {
        return self.todos?.allObjects as? [Todo] ?? []
    }
}

// MARK: Generated accessors for todos
extension AlphaTask {

    @objc(addTodosObject:)
    @NSManaged public func addToTodos(_ value: Todo)

    @objc(removeTodosObject:)
    @NSManaged public func removeFromTodos(_ value: Todo)

    @objc(addTodos:)
    @NSManaged public func addToTodos(_ values: NSSet)

    @objc(removeTodos:)
    @NSManaged public func removeFromTodos(_ values: NSSet)

}

extension AlphaTask : Identifiable {

}

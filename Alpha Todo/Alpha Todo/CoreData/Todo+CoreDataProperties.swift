//
//  Todo+CoreDataProperties.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 30/12/23.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var title: String?
    @NSManaged public var dueDate: Date?
    @NSManaged public var descriptions: String?
    @NSManaged public var isImportant: Bool
    @NSManaged public var isCompleted: Bool
    
    var wrappedTitle: String {
        return self.title ?? ""
    }
    
    var wrappedDueDate: Date {
        return self.dueDate ?? .init()
    }
    
    var wrappedDescriptions: String {
        return self.descriptions ?? ""
    }
    
    var wrappedIsImportant: Bool {
        return self.isImportant
    }
    
    var wrappedIsCompleted: Bool {
        return self.isCompleted
    }
}

extension Todo : Identifiable {

}

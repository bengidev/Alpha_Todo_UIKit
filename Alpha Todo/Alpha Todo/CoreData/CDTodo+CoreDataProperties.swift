//
//  CDTodo+CoreDataProperties.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 31/12/23.
//
//

import Foundation
import CoreData


extension CDTodo {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTodo> {
        return NSFetchRequest<CDTodo>(entityName: "CDTodo")
    }
    
    @NSManaged public var descriptions: String?
    @NSManaged public var dueDate: Date?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var isImportant: Bool
    @NSManaged public var title: String?
    @NSManaged public var task: CDAlphaTask?
    
    var wrappedTitle: String {
        return self.title ?? ""
    }
    
    var wrappedDueDate: Date {
        return self.dueDate ?? .init()
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy 'at' hh:mm a"
        formatter.locale = .current
        
        return formatter.string(from: self.wrappedDueDate)
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

extension CDTodo : Identifiable {
    
}

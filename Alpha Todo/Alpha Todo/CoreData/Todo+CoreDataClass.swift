//
//  Todo+CoreDataClass.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 30/12/23.
//
//

import Foundation
import CoreData

@objc(Todo)
public class Todo: NSManagedObject {
    static let entityName = "Todo"
    static let empty: Todo = .init()
}

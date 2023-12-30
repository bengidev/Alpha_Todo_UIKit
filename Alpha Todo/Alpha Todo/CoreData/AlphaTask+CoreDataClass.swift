//
//  AlphaTask+CoreDataClass.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 30/12/23.
//
//

import Foundation
import CoreData

@objc(AlphaTask)
public class AlphaTask: NSManagedObject {
    static let entityName = "AlphaTask"
    static let empty: AlphaTask = .init()
}

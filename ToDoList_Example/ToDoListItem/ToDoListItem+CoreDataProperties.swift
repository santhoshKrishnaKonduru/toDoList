//
//  ToDoListItem+CoreDataProperties.swift
//  ToDoList_Example
//
//  Created by Santhosh Konduru on 04/10/23.
//
//

import Foundation
import CoreData


extension ToDoListItem {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?

}

extension ToDoListItem : Identifiable {

}

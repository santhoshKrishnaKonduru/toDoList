//
//  ToDoListItem+CoreDataClass.swift
//  ToDoList_Example
//
//  Created by Santhosh Konduru on 04/10/23.
//
//

import Foundation
import CoreData

@objc(ToDoListItem)
public class ToDoListItem: NSManagedObject {

    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
            super.init(entity: entity, insertInto: context)
            print("Init called!")
        }
}

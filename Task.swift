//
//  Task.swift
//  Task
//
//  Created by Steven Patterson on 7/13/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData


class Task: NSManagedObject {

    convenience init?(name: String, notes: String?, due: NSDate? = nil, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        guard let entity = NSEntityDescription.entityForName("Task", inManagedObjectContext: context) else {return nil}
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.due = due
        self.name = name
        self.notes = notes
        self.isComplete = false
    
    }

}

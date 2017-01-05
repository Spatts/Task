//
//  TaskController.swift
//  Task
//
//  Created by Steven Patterson on 7/13/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static let sharedController = TaskController()
    
    let fetchedResultsController: NSFetchedResultsController
    
    init() {
        let request = NSFetchRequest(entityName: "Task")
        let completedDescriptor = NSSortDescriptor(key: "isComplete", ascending: true)
        let dueDescriptor = NSSortDescriptor(key: "due", ascending: true)
        request.sortDescriptors = [completedDescriptor, dueDescriptor]
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: "isComplete", cacheName: nil)
        _ = try? fetchedResultsController.performFetch()
        
    }
    
    func isCompleteValueToggled(task: Task) {
        task.isComplete = !task.isComplete.boolValue
        saveToPersistentStore()
    
    }

    func addTask(name: String, notes: String?, due: NSDate?) {
        let _ = Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
    
    }
    
    func removeTask(task: Task) {
        task.managedObjectContext?.deleteObject(task)
        saveToPersistentStore()
    }
    
    func updateTask(task: Task, name: String, notes: String?, due: NSDate?) {
        task.due = due
        task.notes = notes
        task.name = name
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        do {
            try Stack.sharedStack.managedObjectContext.save()
        } catch {
            print("Dolla Bills YALL!...Or Not")
        }
    }


}
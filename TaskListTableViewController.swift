//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Steven Patterson on 7/13/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController, ButtonTableViewCellDelegate, NSFetchedResultsControllerDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.sharedController.fetchedResultsController.delegate = self
        
    }
    
    
    // MARK: - Table view data source
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let sections = TaskController.sharedController.fetchedResultsController.sections else {return 0}
        return sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = TaskController.sharedController.fetchedResultsController.sections else {return 0}
        return sections[section].numberOfObjects
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as? ButtonTableViewCell,
            task = TaskController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Task else {return ButtonTableViewCell()}
        cell.updateWithTask(task)
        cell.delegate = self
        cell.textLabel?.text = task.name
    
        return cell
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            guard let task = TaskController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Task else {return}
            TaskController.sharedController.removeTask(task)
        }
    }

    func buttonCellButtonTapped(sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPathForCell(sender),
            task = TaskController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Task else {return}
        TaskController.sharedController.isCompleteValueToggled(task)
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionInfo = TaskController.sharedController.fetchedResultsController.sections,
            index = Int(sectionInfo[section].name) else {return nil}
        if index == 0 {
            return "Incomplete Tasks"
        } else {
            return "Complete Tasks"
        }
    }
    
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        case .Insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        case .Move:
            guard let indexPath = indexPath,
                newIndexPath = newIndexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        case .Update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetailSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                task = TaskController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Task else {return}
            let destinationVC = segue.destinationViewController as? TaskDetailTableViewController
            destinationVC?.task = task
        }
    }
        
}
    



//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Steven Patterson on 7/13/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    var task: Task?
    
    var dueDateValue: NSDate?
    
    
    @IBOutlet weak var taskNameText: UITextField!
    
    @IBOutlet weak var taskDueText: UITextField!
    
    @IBOutlet weak var taskNotesText: UITextView!
    
    @IBOutlet var dueDatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        taskDueText.inputView = dueDatePicker
        if let task = task {
            updateWithTask(task)
        }

    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        updateTask()
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func datePickerValueChanged(sender: AnyObject) {
        self.taskDueText.text = sender.date.stringValue()
        self.dueDateValue = sender.date
    }
    
    
    @IBAction func userTappedView(sender: AnyObject) {
        self.taskNameText.resignFirstResponder()
        self.taskDueText.resignFirstResponder()
        self.taskNotesText.resignFirstResponder()
    }
   
    
    func updateTask() {
        
        guard let name = taskNameText.text else {return}
        let due = dueDateValue
        let notes = taskNotesText.text
        
        if let task = self.task {
            TaskController.sharedController.updateTask(task, name: name, notes: notes, due: due)
            TaskController.sharedController.addTask(name, notes: notes, due: due)
        }
    }

    
    func updateWithTask(task: Task) {
        self.task = task
        
        title = task.name
        taskNameText.text = task.name
        
        if let due = task.due {
            taskDueText.text = due.stringValue()
        }
        
        if let notes = task.notes {
            taskNotesText.text = notes
        }
    }

}

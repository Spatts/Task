//
//  DateHelper.swift
//  Task
//
//  Created by Steven Patterson on 7/14/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

extension NSDate {
    
    func stringValue() -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        
        return formatter.stringFromDate(self)
    }
    
}
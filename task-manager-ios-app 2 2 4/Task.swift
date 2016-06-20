//
//  Task.swift
//  TaskManager
//
//  Created by admin on 9/14/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation
import CoreData

@objc(Task)
class Task: NSManagedObject {

    @NSManaged var deadline: String
    @NSManaged var dependentTask: String
    @NSManaged var priority: NSNumber
    @NSManaged var projectName: String
    @NSManaged var taskDesc: String
    @NSManaged var taskType: String
    @NSManaged var taskName: String
    @NSManaged var projectTask: NSSet

}

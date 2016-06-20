//
//  Project.swift
//  TaskManager
//
//  Created by admin on 9/14/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation
import CoreData

@objc(Project)
class Project: NSManagedObject {

    @NSManaged var projectDeadline: String
    @NSManaged var projectDesc: String
    @NSManaged var projectName: String
    @NSManaged var projectTask: NSSet

}

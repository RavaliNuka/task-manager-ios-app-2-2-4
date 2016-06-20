//
//  ProjectTask.swift
//  TaskManager
//
//  Created by admin on 9/14/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation
import CoreData


@objc(ProjectTask)
class ProjectTask: NSManagedObject {

    @NSManaged var project: Project
    @NSManaged var task: Task

}

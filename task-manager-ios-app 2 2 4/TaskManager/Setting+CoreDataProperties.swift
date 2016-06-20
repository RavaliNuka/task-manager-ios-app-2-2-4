//
//  Setting+CoreDataProperties.swift
//  TaskManager
//
//  Created by sravya madarapu on 22/11/15.
//  Copyright © 2015 Student. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Setting {

    @NSManaged var priorityLimit: NSNumber?
    @NSManaged var red: NSNumber?
    @NSManaged var green: NSNumber?
    @NSManaged var blue: NSNumber?

}

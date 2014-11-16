//
//  User.swift
//  pollingapp
//
//  Created by Amol Chaudhari on 11/15/14.
//  Copyright (c) 2014 MadBullTechnologies. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var userName: String
    @NSManaged var profileImagePath: String
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var pollSet: NSSet

}

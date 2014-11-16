//
//  Poll.swift
//  pollingapp
//
//  Created by Amol Chaudhari on 11/15/14.
//  Copyright (c) 2014 MadBullTechnologies. All rights reserved.
//

import Foundation
import CoreData

class Poll: NSManagedObject {

    @NSManaged var pollName: String
    @NSManaged var desc: String
    @NSManaged var question: String
    @NSManaged var pollOptionType: NSNumber
    @NSManaged var startDate: NSDate
    @NSManaged var endDate: NSDate
    @NSManaged var userName: String
    @NSManaged var publicPrivatePollType: NSNumber
    @NSManaged var optionSet: NSSet
    @NSManaged var user: User

}

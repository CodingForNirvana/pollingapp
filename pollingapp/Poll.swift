//
//  Poll.swift
//  pollingapp
//
//  Created by Amol Chaudhari on 11/16/14.
//  Copyright (c) 2014 MadBullTechnologies. All rights reserved.
//

import Foundation
import CoreData


enum PollOptionType:Int {
    case UnknownNone = 0, TextType = 1, ImageType = 2
}

enum PublicPrivatePollType:Int {
    case UnknownNone = 0, PublicType = 1, PrivateType = 2
}

class Poll: NSManagedObject {

    @NSManaged var endDate: NSDate
    @NSManaged var pollOptionType: NSNumber
    @NSManaged var publicPrivatePollType: NSNumber
    @NSManaged var question: String
    @NSManaged var startDate: NSDate
    @NSManaged var optionSet: NSSet
    @NSManaged var user: User

}

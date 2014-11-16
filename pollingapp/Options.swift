//
//  Options.swift
//  pollingapp
//
//  Created by Amol Chaudhari on 11/15/14.
//  Copyright (c) 2014 MadBullTechnologies. All rights reserved.
//

import Foundation
import CoreData

class Options: NSManagedObject {

    @NSManaged var optionString: String
    @NSManaged var imagePath: String
    @NSManaged var totalVotes: NSNumber
    @NSManaged var poll: Poll

}

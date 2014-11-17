//
//  Options.swift
//  pollingapp
//
//  Created by Amol Chaudhari on 11/16/14.
//  Copyright (c) 2014 MadBullTechnologies. All rights reserved.
//

import Foundation
import CoreData

class Options: NSManagedObject {

    @NSManaged var imagePath: String
    @NSManaged var optionString: String
    @NSManaged var totalVotes: NSNumber
    @NSManaged var poll: Poll

}

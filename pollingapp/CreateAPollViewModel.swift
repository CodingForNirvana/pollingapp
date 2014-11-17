//
//  CreateAPollViewModel.swift
//  pollingapp
//
//  Created by Amol Chaudhari on 11/16/14.
//  Copyright (c) 2014 MadBullTechnologies. All rights reserved.
//

import Foundation


class CreateAPollViewModel:NSObject {
    
    var questionText: String?
    var optionAText: String?
    var optionBText: String?
    var durationText: String?
    var durationInNumberOfDays:Int?
    
    var optionAImage: NSData?
    var optionBImage: NSData?
    
    func saveModel() {
        var coreDataManager = CoreDataManager()
        coreDataManager.saveNewPoll(self)
    }
}
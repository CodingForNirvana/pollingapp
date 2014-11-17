//
//  CoreDataManager.swift
//  pollingapp
//
//  Created by Amol Chaudhari on 11/16/14.
//  Copyright (c) 2014 MadBullTechnologies. All rights reserved.
//

import Foundation
import CoreData


class CoreDataManager: NSObject {
    
    lazy var privateManagedObjectContext: NSManagedObjectContext? = {
      
        var privateManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        let appDelegate:AppDelegate =  UIApplication.sharedApplication().delegate as AppDelegate
        privateManagedObjectContext.parentContext = appDelegate.mainManagedObjectContext
        return privateManagedObjectContext
        }()
    
    
    override init() {
        super.init()
    }

    func getCurrentUsersPolls() -> NSArray? {
        
        var keychainStore = UICKeyChainStore(service: kKeychainServiceName)
        let username = keychainStore.stringForKey(kUsername)

        let request = NSFetchRequest(entityName: "User")
        var error:NSError? = nil
        
        request.predicate = NSPredicate(format: "userName like %@", username)
        let userArray: NSArray = self.privateManagedObjectContext?.executeFetchRequest(request, error: &error) as [User]
        
        
        if userArray.count > 0 {
            var user: User = userArray[0] as User;
            var allPolls = user.pollSet.allObjects as NSArray;
            return allPolls
        }
        return nil
    }
    
    func saveNewPoll(createAPollViewModel:CreateAPollViewModel) {
        
        self.privateManagedObjectContext!.performBlock {
            
            //Insert new poll on the managedobjectcontext
            let newPoll = NSEntityDescription.insertNewObjectForEntityForName("Poll", inManagedObjectContext: self.privateManagedObjectContext!) as Poll
            
            newPoll.question = createAPollViewModel.questionText!;
            newPoll.startDate = NSDate();
            newPoll.pollOptionType = NSNumber(integer: PollOptionType.TextType.rawValue)
            newPoll.publicPrivatePollType = NSNumber(integer: PublicPrivatePollType.PublicType.rawValue)
            
            var daysToAdd = createAPollViewModel.durationInNumberOfDays
            var todaysDate = NSDate()
            var totalTimeInterval:NSTimeInterval = Double(60*60*24*daysToAdd!)
            var newDate = todaysDate.dateByAddingTimeInterval(totalTimeInterval)
            newPoll.endDate = newDate
            
            
            
            var keychainStore = UICKeyChainStore(service: kKeychainServiceName)
            let username = keychainStore.stringForKey(kUsername)
            
            
            let request = NSFetchRequest(entityName: "User")
            var error:NSError? = nil
            
            request.predicate = NSPredicate(format: "userName like %@", username)
            let userArray: NSArray = self.privateManagedObjectContext?.executeFetchRequest(request, error: &error) as [User]
            
            if userArray.count > 0 {
                let userManagedObject:User = userArray[0] as User
                newPoll.user = userManagedObject
            } else {
                var firstName = keychainStore.stringForKey(kFirstName)
                var lastName =  keychainStore.stringForKey(kLastName)
                var user = self.createNewUser(username, firstName: firstName, lastName: lastName, profileImagePath: "")
                newPoll.user = user
            }
            
            
            self.saveContext()
        }
    }
    
    func createNewUser(username:String, firstName:String, lastName:String, profileImagePath:String) -> User {
        
        //Should not be called on main thread. This is used as private function incase the user has not been created. This could be used to update the user
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: self.privateManagedObjectContext!) as User
        newUser.userName = username
        newUser.firstName = firstName
        newUser.lastName = lastName
        newUser.profileImagePath = profileImagePath
        return newUser
    }
    
    func saveContext() {
      
        self.privateManagedObjectContext!.performBlock {
            var error: NSError? = nil
            if self.privateManagedObjectContext!.hasChanges && !self.privateManagedObjectContext!.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
            
            let appDelegate:AppDelegate =  UIApplication.sharedApplication().delegate as AppDelegate
            appDelegate.saveMainContext(); //Save main context
        }
    
    }
    
}
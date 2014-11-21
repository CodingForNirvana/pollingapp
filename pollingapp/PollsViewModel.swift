//
//  PollsViewModel.swift
//  pollingapp
//
//  Created by Amol Chaudhari on 11/20/14.
//  Copyright (c) 2014 MadBullTechnologies. All rights reserved.
//

import Foundation
import CoreData

class PollsViewModel: NSObject, NSFetchedResultsControllerDelegate {
    
    weak var pollsViewController:PollsViewController?;
    
    var shouldReloadCollectionView = false;
    var blockOperation:NSBlockOperation = NSBlockOperation()
    
    lazy var fetchedResultsController: NSFetchedResultsController? = {
        let appDelegate:AppDelegate =  UIApplication.sharedApplication().delegate as AppDelegate;
        var mainManagedObjectContext = appDelegate.mainManagedObjectContext;
        
        let fetchRequest = NSFetchRequest(entityName: "Poll");
        let sortDescriptor = NSSortDescriptor(key: "startDate", ascending: false);
       
        fetchRequest.sortDescriptors = [sortDescriptor];
        var fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: mainManagedObjectContext!, sectionNameKeyPath: nil, cacheName: nil);
        fetchedResultsController.delegate = self
        
        var fetchError:NSError? = nil
        fetchedResultsController.performFetch(&fetchError)
        
        if(fetchError != nil) {
            NSException(name: "NSFetchedResultsControllerError", reason: fetchError?.description, userInfo: nil).raise()
        }
        
        return fetchedResultsController
        }()
    
    init(usingPollsViewController pollsViewController: PollsViewController) {
        self.pollsViewController = pollsViewController
    }
    
    //MARK: NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.shouldReloadCollectionView = false;
        self.blockOperation = NSBlockOperation();
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
        case NSFetchedResultsChangeType.Insert:
            self.blockOperation.addExecutionBlock({
                var indexSet = NSIndexSet(index: sectionIndex);
                self.pollsViewController?.collectionView.insertSections(indexSet)
            });
            break
            
        case NSFetchedResultsChangeType.Delete:
            self.blockOperation.addExecutionBlock({ () -> Void in
                var indexSet = NSIndexSet(index: sectionIndex);
               self.pollsViewController?.collectionView.deleteSections(indexSet)
            });
            break
            
        case NSFetchedResultsChangeType.Update:
            self.blockOperation.addExecutionBlock({ () -> Void in
                var indexSet = NSIndexSet(index: sectionIndex);
                self.pollsViewController?.collectionView.reloadSections(indexSet)
            });
            break
            
        default:
            break
        }
    }

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        var section:Int = indexPath!.section as Int

        switch type {
        case NSFetchedResultsChangeType.Insert:
            if(self.pollsViewController?.collectionView.numberOfSections() > 0) {
                if(self.pollsViewController?.collectionView.numberOfItemsInSection(section) == 0) {
                    self.shouldReloadCollectionView = true;
                } else {
                    self.blockOperation.addExecutionBlock({
                        var newPath = newIndexPath!
                        self.pollsViewController?.collectionView.insertItemsAtIndexPaths([newPath]);
                    });
                }
                
            } else {
                self.shouldReloadCollectionView = true;
            }
            
            
            break
            
        case NSFetchedResultsChangeType.Delete:
            if(self.pollsViewController?.collectionView.numberOfItemsInSection(section) == 1) {
                self.shouldReloadCollectionView = true;
            } else {
                self.blockOperation.addExecutionBlock({ () -> Void in
                    var oldIndexPath = indexPath!
                    self.pollsViewController?.collectionView.deleteItemsAtIndexPaths([oldIndexPath])
                });
            }

            break
            
        case NSFetchedResultsChangeType.Update:
            self.blockOperation.addExecutionBlock({ () -> Void in
                var oldIndexPath = indexPath!
                self.pollsViewController?.collectionView.reloadItemsAtIndexPaths([oldIndexPath])
            });
            break
            
        case NSFetchedResultsChangeType.Move:
            self.blockOperation.addExecutionBlock({ () -> Void in
                var oldIndexPath = indexPath!
                var newPath = newIndexPath!
                self.pollsViewController?.collectionView.moveItemAtIndexPath(oldIndexPath, toIndexPath: newPath)
            });
            break

        default:
            break
        }
    }


    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        // Checks if we should reload the collection view to fix a bug @ http://openradar.appspot.com/12954582
        
        if(self.shouldReloadCollectionView) {
            self.pollsViewController?.collectionView.reloadData()
            return
        }
        
        self.pollsViewController?.collectionView.performBatchUpdates({ () -> Void in
            self.blockOperation.start()
        }, completion: nil)
        
    }
    
}




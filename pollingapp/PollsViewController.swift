//
//  PollsViewController.swift
//  pollingapp
//
//  Created by Amol Chaudhari on 11/16/14.
//  Copyright (c) 2014 MadBullTechnologies. All rights reserved.
//

import UIKit
import CoreData

class PollsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func openMenuTapped(AnyObject) {
        
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true) { (Bool finished) -> Void in
            
        }
    }
    
    var pollViewModel:PollsViewModel!;
    let coredataManager = CoreDataManager()
    
    required init(coder aDecoder: NSCoder) {
        //  fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.pollViewModel = PollsViewModel(usingPollsViewController: self)

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 90)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if let sections = self.pollViewModel.fetchedResultsController?.sections {
           return sections.count;
        }
        return 0;
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sectionsArray = self.pollViewModel.fetchedResultsController?.sections {
            var sectionsInfo: NSFetchedResultsSectionInfo = sectionsArray[section] as NSFetchedResultsSectionInfo
            return sectionsInfo.numberOfObjects;
        }

        return 0;
    }

    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as PollsCollectionViewCell
        cell.backgroundColor = UIColor.blackColor()
        
        var poll:Poll = self.pollViewModel.fetchedResultsController?.objectAtIndexPath(indexPath) as Poll
        cell.question.text = poll.question
        return cell
    }

    
}

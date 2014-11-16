//
//  PollsViewController.swift
//  pollingapp
//
//  Created by Amol Chaudhari on 11/16/14.
//  Copyright (c) 2014 MadBullTechnologies. All rights reserved.
//

import UIKit


class PollsViewController: UIViewController {
    
    
    @IBAction func openMenuTapped(AnyObject) {
        
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true) { (Bool finished) -> Void in
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

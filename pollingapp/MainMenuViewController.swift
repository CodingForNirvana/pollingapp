//
//  MainMenuViewController.swift
//  pollingapp
//
//  Created by Amol Chaudhari on 11/16/14.
//  Copyright (c) 2014 MadBullTechnologies. All rights reserved.
//

import UIKit


class MainMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    required init(coder aDecoder: NSCoder) {
     //   fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    var tableViewCellItems: [String] = ["Create a poll", "Public poles", "Settings"]

    @IBOutlet
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       // self.tableView?.registerClass(MainMenuCellView.self, forCellReuseIdentifier: "MainMenuCellView")
        
        self.tableView?.separatorColor =  UIColor.clearColor();
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewCellItems.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:MainMenuCellView = self.tableView?.dequeueReusableCellWithIdentifier("MainMenuCellView")! as MainMenuCellView
        //cell.textLabel.text = self.tableViewCellItems[indexPath.row]
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width)
        
        cell.cellTitleLabel.text = self.tableViewCellItems[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        
        switch indexPath.row {
            case 0:
                var storyboard = UIStoryboard(name: "CreatePollStoryboard", bundle: nil)
                var createAPollViewController = storyboard.instantiateViewControllerWithIdentifier("CreateAPollViewControllerId") as CreateAPollViewController;
                self.mm_drawerController.setCenterViewController(createAPollViewController as UIViewController, withCloseAnimation: true, completion: nil) ;
                
            break
        case 1:
            
            var mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        
            var pollsViewController:UINavigationController = mainStoryboard.instantiateViewControllerWithIdentifier("PollsNavigationControllerId") as UINavigationController
            self.mm_drawerController.setCenterViewController(pollsViewController as UINavigationController, withCloseAnimation: true, completion: nil) ;

            break;
        case 2:
            
            break;
        default:
            break;
        }
        
    }
    
    
}

//
//  ViewController.swift
//  pollingapp
//
//  Created by Amol Chaudhari on 11/15/14.
//  Copyright (c) 2014 MadBullTechnologies. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func loginTapped(AnyObject) {
        
        var mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

        var mainMenuViewController:MainMenuViewController = mainStoryboard.instantiateViewControllerWithIdentifier("MainMenuViewControllerId")
         as MainMenuViewController
        
        var pollsViewController:UINavigationController = mainStoryboard.instantiateViewControllerWithIdentifier("PollsNavigationControllerId") as UINavigationController
        
        var mmDrawerViewController = MMDrawerController(centerViewController: pollsViewController, leftDrawerViewController: mainMenuViewController);
        
        mmDrawerViewController.openDrawerGestureModeMask = MMOpenDrawerGestureMode.All
        mmDrawerViewController.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.All
        
        
        self.presentViewController(mmDrawerViewController, animated: true) { () -> Void in
            //Saving constant username password in keychain. Please change it later on.
            var keychainStore = UICKeyChainStore(service: kKeychainServiceName)
            keychainStore.setString("amolTestUsername", forKey: kUsername)
            keychainStore.setString("passwordShoudbehidden", forKey: kPassword)
            keychainStore.setString("Amol", forKey: kFirstName)
            keychainStore.setString("chaudhari", forKey: kLastName)
            keychainStore.setString("chaudhari.amol.sopan@gmail.com", forKey: kEmailId)

            keychainStore.synchronize(); // Write to keychain.

        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var leftViewController = UIViewController();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ReviewAPollViewController.swift
//  pollingapp
//
//  Created by Amol Chaudhari on 11/16/14.
//  Copyright (c) 2014 MadBullTechnologies. All rights reserved.
//

import UIKit

class ReviewAPollViewController: UIViewController {
    
    
    @IBOutlet weak var reviewQuestionTextView: UITextView?
    @IBOutlet weak var reviewOptionATextView: UITextView?
    @IBOutlet weak var reviewOptionBTextView: UITextView?
    @IBOutlet weak var reviewDurationLabel:    UILabel?
    
    var createAPollViewModel: CreateAPollViewModel?

    
    override func viewDidLoad() {
        self.reviewQuestionTextView?.text = self.createAPollViewModel?.questionText
        self.reviewOptionATextView?.text = self.createAPollViewModel?.optionAText
        self.reviewOptionBTextView?.text = self.createAPollViewModel?.optionBText
        self.reviewDurationLabel?.text = self.createAPollViewModel?.durationText
        
    }
    
    
    @IBAction func pollSubmitted(AnyObject) {
        
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        //Need to make a network request before saving the models.
        self.createAPollViewModel?.saveModel()
    }

}
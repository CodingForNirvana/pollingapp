//
//  CreateAPollViewController.swift
//  pollingapp
//
//  Created by Amol Chaudhari on 11/16/14.
//  Copyright (c) 2014 MadBullTechnologies. All rights reserved.
//

import UIKit

class CreateAPollViewController: UIViewController, UIPickerViewDataSource,  UIPickerViewDelegate {

    
    @IBOutlet weak var questionTextView: UITextView?
    @IBOutlet weak var optionATextField: UITextField?
    @IBOutlet weak var optionBTextField: UITextField?

    @IBOutlet weak var durationPickerView: UIPickerView?
    
    var selectedDuration: String?
    
    let pickerData = ["Select poll duration..", "1 day", "2 days", "3 days", "4 days", "5 days", "6 days", "1 week", "2 weeks", "3 weeks", "4 weeks"]
    
    let pickerDataDictionary = [
        "1 Day":1,
        "2 days":2,
        "3 days":3,
        "4 days":4,
        "5 days":5,
        "6 days":6,
        "1 week":7,
        "2 weeks":14,
        "3 weeks":21,
        "4 weeks":28
    ]
    
    //Mark : ViewController Lifecycle
    
    required init(coder aDecoder: NSCoder) {
        //  fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tappedInView:")
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func tappedInView(sender: UITapGestureRecognizer!) {
        optionATextField?.resignFirstResponder()
        optionBTextField?.resignFirstResponder()
        questionTextView?.resignFirstResponder()
    }
    
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedDuration = pickerData[row]
    }
    
    //MARK: Storyboard overrides
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        
        var errorString: String?
        
        if( self.selectedDuration == nil || self.selectedDuration == pickerData[0]) {
            errorString = "Please select a valid poll duration"
        }
        
        if(self.optionATextField?.text == nil) {
            errorString = "Please enter option 1"
        }
        
        if(self.optionBTextField?.text == nil) {
            errorString = "Please enter option 2"
        }
        
        if(self.questionTextView?.text == nil || self.questionTextView?.text == "Enter your question here...") {
            errorString = "Please enter a valid question"
        }

        
        if(errorString != nil) {
            var alert = UIAlertController(title: "Error", message: errorString, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        }
        
        return true;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var reviewViewAPollViewController: ReviewAPollViewController = segue.destinationViewController as ReviewAPollViewController;
        
        var createAPollViewModel:CreateAPollViewModel = CreateAPollViewModel()
        
        createAPollViewModel.questionText = self.questionTextView?.text;
        createAPollViewModel.optionAText = self.optionATextField?.text;
        createAPollViewModel.optionBText = self.optionBTextField?.text;
        createAPollViewModel.durationText = self.selectedDuration;
        createAPollViewModel.durationInNumberOfDays = self.pickerDataDictionary[self.selectedDuration!];
        
        reviewViewAPollViewController.createAPollViewModel = createAPollViewModel;
        
    }

    
}
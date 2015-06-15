//
//  GSettingsTableViewController.swift
//  Mobile Assistant
//
//  Created by RitcheldaV on 26/3/15.
//  Copyright (c) 2015 Cloudstaff. All rights reserved.
//

import UIKit


class GSettingsTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtSecond: UITextField!
    @IBOutlet weak var txtThird: UITextField!
    @IBOutlet weak var txtFourth: UITextField!
    @IBOutlet weak var txtFifth: UITextField!
    @IBOutlet weak var txtYourEmail: UITextField!
    @IBOutlet weak var txtCSUsername: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
        
    ///////////////////////  KEYBOARD DISMISS  /////////////////////////
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    ////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtCSUsername.delegate = self
        txtEmailAddress.delegate = self
        txtFifth.delegate = self
        txtFirst.delegate = self
        txtFourth.delegate = self
        txtMobileNumber.delegate = self
        txtSecond.delegate = self
        txtThird.delegate = self
        txtYourEmail.delegate = self
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hideKeyboard")
        
        // prevents the scroll view from swallowing up the touch event of child buttons
        tapGesture.cancelsTouchesInView = false
        
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    @IBAction func back(sender: UIBarButtonItem) {
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        
        if (section == 0) {
            returnValue = 5
        } else if (section == 1) {
            returnValue = 1
        } else if (section == 2) {
            returnValue = 3
        }
        
        return returnValue
    }
    
    func hideKeyboard() {
        txtEmailAddress.resignFirstResponder()
        txtCSUsername.resignFirstResponder()
        txtFifth.resignFirstResponder()
        txtFirst.resignFirstResponder()
        txtFourth.resignFirstResponder()
        txtMobileNumber.resignFirstResponder()
        txtSecond.resignFirstResponder()
        txtThird.resignFirstResponder()
        txtYourEmail.resignFirstResponder()
    }
    
}

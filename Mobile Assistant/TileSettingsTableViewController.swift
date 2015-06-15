//
//  TileSettingsTableViewController.swift
//  Mobile Assistant
//
//  Created by RitcheldaV on 10/4/15.
//  Copyright (c) 2015 Cloudstaff. All rights reserved.
//

import UIKit

class TileSettingsTableViewController: UITableViewController, UITextFieldDelegate {

    var selectedIcon = ""
    var sendToCloudstaffer: Bool = false
    var sendToEmail: Bool = false
    var sendToPhone: Bool = false
    var imageSize: Float = 0
    var sendOnTap: Bool = false
    var safetySend: Bool = false
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtSubject: UITextField!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var lblThird: UILabel!
    @IBOutlet weak var lblFourth: UILabel!
    @IBOutlet weak var lblFifth: UILabel!
    @IBOutlet weak var lblSched: UILabel!
    @IBOutlet weak var lblXheader: UILabel!
        
    @IBOutlet weak var swSafetySend: UISwitch!
    
    let prefs = NSUserDefaults.standardUserDefaults()
    
    var alert = AlertDialogs()
    
    ///////////////////////  KEYBOARD DISMISS  /////////////////////////
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    ////////////////////////////////////////////////////////////////////
    
    override func viewWillAppear(animated: Bool) {
        if let firstLoad = prefs.stringForKey("selectedIcon") {
            selectedIcon = prefs.stringForKey("selectedIcon")!
        }
        if count(selectedIcon) != 0 {
            imgIcon.image = UIImage(named: selectedIcon)
        }
        
        if prefs.stringForKey("TextEditor") == "Set Message" {
            lblMessage.text = prefs.stringForKey("teValue")
        }
        
        if prefs.stringForKey("TextEditor") == "First Options" {
            lblFirst.text = prefs.stringForKey("teValue")
        }
        
        if prefs.stringForKey("TextEditor") == "Second Options" {
            lblSecond.text = prefs.stringForKey("teValue")
        }
        
        if prefs.stringForKey("TextEditor") == "Third Options" {
            lblThird.text = prefs.stringForKey("teValue")
        }
        
        if prefs.stringForKey("TextEditor") == "Fourth Options" {
            lblFourth.text = prefs.stringForKey("teValue")
        }
        
        if prefs.stringForKey("TextEditor") == "Fifth Options" {
            lblFifth.text = prefs.stringForKey("teValue")
        }
        
        if prefs.stringForKey("TextEditor") == "Email Header" {
            lblXheader.text = prefs.stringForKey("teValue")
        }
        
        prefs.setValue("", forKey: "teValue")
        prefs.setValue("", forKey: "TextEditor")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prefs.setValue("", forKey: "teValue")
        
        lblMessage.text = "None"
        lblFirst.text = "None"
        lblSecond.text = "None"
        lblThird.text = "None"
        lblFourth.text = "None"
        lblFifth.text = "None"
        lblSched.text = "None"
        lblXheader.text = "None"
        
        selectedIcon = "add_new_tile_icon"
        
        txtTitle.delegate = self
        txtUsername.delegate = self
        txtEmailAddress.delegate = self
        txtPhoneNumber.delegate = self
        txtSubject.delegate = self
        
        if prefs.boolForKey("newTile") {
            txtTitle.becomeFirstResponder()
        }        
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hideKeyboard")
        
        // prevents the scroll view from swallowing up the touch event of child buttons
        tapGesture.cancelsTouchesInView = false
        
        self.view.addGestureRecognizer(tapGesture)
        
    }
    

    @IBAction func back(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
        
        println("Selected Icon \(selectedIcon)")
        println("Title: \(txtTitle.text)")
        println("Email My Cloudstaffer: \(sendToCloudstaffer)")
        println("Username: \(txtUsername.text)")
        println("Send to Email: \(sendToEmail)")
        println("Email Address: \(txtEmailAddress.text)")
        println("Send to Mobile Phone: \(sendToPhone)")
        println("Phone Number: \(txtPhoneNumber.text)")
        println("Subject: \(txtSubject.text)")
        println("Message: \(lblMessage.text!)")
        println("First Options: \(lblFirst.text!)")
        println("Fourth Options: \(lblSecond.text!)")
        println("Third Options: \(lblThird.text!)")
        println("Fourth Options: \(lblFourth.text!)")
        println("Fifth Options: \(lblFifth.text!)")
        println("Resize Image: \(imageSize)")
        println("Schedule: \(lblSched.text!)")
        println("Send on Tap: \(sendOnTap)")
        println("Safety Send: \(safetySend)")
        println("Email Header: \(lblXheader.text!)")
        
        prefs.setBool(false, forKey: "newTile")
        
        prefs.setValue("", forKey: "selectedIcon")
        
        prefs.setValue("", forKey: "TextEditor")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 12
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        
        if (section == 0) {
            returnValue = 2
        } else if (section == 1) {
            returnValue = 2
        } else if (section == 2) {
            returnValue = 2
        } else if (section == 3) {
            returnValue = 2
        } else if (section == 4) {
            returnValue = 2
        } else if (section == 5) {
            returnValue = 5
        } else if (section == 6) {
            returnValue = 1
        } else if (section == 7) {
            returnValue = 1
        } else if (section == 8) {
            returnValue = 1
        } else if (section == 9) {
            returnValue = 1
        } else if (section == 10) {
            returnValue = 1
        } else if (section == 11) {
            returnValue = 1
        }
        
        return returnValue
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if indexPath == NSIndexPath(forRow: 0, inSection: 0) {
            prefs.setValue("", forKey: "selectedIcon")
            self.performSegueWithIdentifier("toIcons", sender: self)
        }
        
        if indexPath == NSIndexPath(forRow: 1, inSection: 4) {
            prefs.setValue("Set Message", forKey: "TextEditor")
            prefs.setValue(lblMessage.text, forKey: "teValue")
            self.performSegueWithIdentifier("toTextEditor", sender: self)
        }
        
        if indexPath == NSIndexPath(forRow: 0, inSection: 5) {
            prefs.setValue("First Options", forKey: "TextEditor")
            prefs.setValue(lblFirst.text, forKey: "teValue")
            self.performSegueWithIdentifier("toTextEditor", sender: self)
        }
        
        if indexPath == NSIndexPath(forRow: 1, inSection: 5) {
            prefs.setValue("Second Options", forKey: "TextEditor")
            prefs.setValue(lblSecond.text, forKey: "teValue")
            self.performSegueWithIdentifier("toTextEditor", sender: self)
        }
        
        if indexPath == NSIndexPath(forRow: 2, inSection: 5) {
            prefs.setValue("Third Options", forKey: "TextEditor")
            prefs.setValue(lblThird.text, forKey: "teValue")
            self.performSegueWithIdentifier("toTextEditor", sender: self)
        }
        
        if indexPath == NSIndexPath(forRow: 3, inSection: 5) {
            prefs.setValue("Fourth Options", forKey: "TextEditor")
            prefs.setValue(lblFourth.text, forKey: "teValue")
            self.performSegueWithIdentifier("toTextEditor", sender: self)
        }
        
        if indexPath == NSIndexPath(forRow: 4, inSection: 5) {
            prefs.setValue("Fifth Options", forKey: "TextEditor")
            prefs.setValue(lblFifth.text, forKey: "teValue")
            self.performSegueWithIdentifier("toTextEditor", sender: self)
        }
        
        if indexPath == NSIndexPath(forRow: 0, inSection: 7) {
            setSchedule()
        }
        
        if indexPath == NSIndexPath(forRow: 0, inSection: 10) {
            prefs.setValue("Email Header", forKey: "TextEditor")
            prefs.setValue(lblXheader.text, forKey: "teValue")
            self.performSegueWithIdentifier("toTextEditor", sender: self)
        }
        
        if indexPath == NSIndexPath(forRow: 0, inSection: 11) {
            deleteTile()
        }
    }

    func setSchedule() {
        let optionMenu = UIAlertController(title: "Set Schedule", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let urgentAtion = UIAlertAction(title: "Urgent", style: UIAlertActionStyle.Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.lblSched.text = "Urgent"
        })
        
        let tomorrowAction = UIAlertAction(title: "Tomorrow", style: UIAlertActionStyle.Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.lblSched.text = "Tomorrow"
        })
        
        let nextWeekAtion = UIAlertAction(title: "Next Week", style: UIAlertActionStyle.Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.lblSched.text = "Next Week"
        })
        
        let noneAction = UIAlertAction(title: "None", style: UIAlertActionStyle.Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.lblSched.text = "None"
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
            println("Cancelled")
        })
        
        
        optionMenu.addAction(urgentAtion)
        optionMenu.addAction(tomorrowAction)
        optionMenu.addAction(nextWeekAtion)
        optionMenu.addAction(noneAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    
    func deleteTile() {
        let optionMenu = UIAlertController(title: "Delete This Tile", message: "Are you sure you want to delete tile permanently?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let yesAtion = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            
            println("Deleted Tile!")
            self.navigationController?.popViewControllerAnimated(true)
        })
        
        let noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            println("Cancelled!")
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
            println("Cancelled")
        })
        
        optionMenu.addAction(yesAtion)
        optionMenu.addAction(noAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func sendToCloudstaffer(sender: UISwitch) {
        println(sender.on)
        sendToCloudstaffer = sender.on
    }
    
    @IBAction func sendToEmail(sender: UISwitch) {
        println(sender.on)
        sendToEmail = sender.on
    }
    
    @IBAction func sendToPhone(sender: UISwitch) {
        println(sender.on)
        sendToPhone = sender.on
    }
    
    @IBAction func resizeImage(sender: UISlider) {
        println(sender.value)
        imageSize = sender.value
    }
    
    
    @IBAction func sendOnTap(sender: UISwitch) {
        println(sender.on)
        sendOnTap = sender.on
        
        if sendOnTap {
            setSendOnTap()
        }
    }
    
    @IBAction func safetySend(sender: UISwitch) {
        println(sender.on)
        safetySend = sender.on
        
        if safetySend {
            setSafetySend()
        }
    }
    
    func hideKeyboard() {
        txtTitle.resignFirstResponder()
        txtUsername.resignFirstResponder()
        txtSubject.resignFirstResponder()
        txtPhoneNumber.resignFirstResponder()
        txtEmailAddress.resignFirstResponder()
    }
    
    func setSendOnTap() {
        let optionMenu = UIAlertController(title: "What is Send on Tap?", message: "When enabling Send on Tap for this Tile - message(s) will be automatically sent when the icon is tapped - you will not need to press the Cloudstaff Logo to send.", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let okAtion = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.sendOnTap = true
        })
        
        optionMenu.addAction(okAtion)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    
    func setSafetySend() {
        let optionMenu = UIAlertController(title: "Safety Send", message: "Are you sure you want to send this message to {Cloudstaffer}?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let okAtion = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.safetySend = true
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.safetySend = false
            
            self.swSafetySend.setOn(false, animated: true)
            
            println("Cancelled")
        })
        
        optionMenu.addAction(okAtion)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
}

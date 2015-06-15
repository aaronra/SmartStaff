//
//  DisclaimerViewController.swift
//  Mobile Assistant
//
//  Created by RitcheldaV on 30/3/15.
//  Copyright (c) 2015 Cloudstaff. All rights reserved.
//

import UIKit
import Darwin

class DisclaimerViewController: UIViewController {

    let prefs = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet var leftButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstLoad = prefs.stringForKey("firstLoad") {
            println("This is NOT the first time to load the application" + firstLoad)
        } else {
            //            prefs.setValue("Yes", forKey: "firstLoad")
            println("FIRST TIME")
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Disagree", style: UIBarButtonItemStyle.Bordered, target: self, action: "disagreed:")
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Agree", style: UIBarButtonItemStyle.Bordered, target: self, action: "agreed:")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func disagreed(sender: UIBarButtonItem) {
        println("DISAGREED!")
        exit(0)
    }
    
    func agreed(sender: UIBarButtonItem) {
        println("AGREED!")
//        prefs.setValue("Yes", forKey: "firstLoad")
        performSegueWithIdentifier("toStartupWizard", sender: self)
    }

    @IBAction func back(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    
}

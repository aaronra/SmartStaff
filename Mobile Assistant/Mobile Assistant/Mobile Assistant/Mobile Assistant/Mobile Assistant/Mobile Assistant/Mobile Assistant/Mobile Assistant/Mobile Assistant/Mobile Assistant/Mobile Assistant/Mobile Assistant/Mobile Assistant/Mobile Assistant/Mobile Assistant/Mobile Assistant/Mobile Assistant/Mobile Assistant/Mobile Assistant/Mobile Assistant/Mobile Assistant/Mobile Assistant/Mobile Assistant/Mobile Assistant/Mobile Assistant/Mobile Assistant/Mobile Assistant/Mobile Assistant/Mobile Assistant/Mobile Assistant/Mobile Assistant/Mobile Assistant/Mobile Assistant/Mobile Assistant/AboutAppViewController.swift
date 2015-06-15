//
//  AboutAppViewController.swift
//  Mobile Assistant
//
//  Created by RitcheldaV on 30/3/15.
//  Copyright (c) 2015 Cloudstaff. All rights reserved.
//

import UIKit

class AboutAppViewController: UIViewController {

    @IBOutlet var version: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let appInfo = NSBundle.mainBundle().infoDictionary as! Dictionary<String,AnyObject>
        let shortVersionString = appInfo["CFBundleShortVersionString"] as! String
        let bundleVersion = appInfo["CFBundleVersion"]as! String
        let appVersion = shortVersionString + "." + bundleVersion
        
        version.text = "Version " + appVersion
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    @IBAction func back(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    
}

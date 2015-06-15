//
//  AboutCSViewController.swift
//  Mobile Assistant
//
//  Created by RitcheldaV on 30/3/15.
//  Copyright (c) 2015 Cloudstaff. All rights reserved.
//

import UIKit

class AboutCSViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "http://www.cloudstaff.com")
        let requestObj = NSURLRequest(URL: url!)
        
        webView.loadRequest(requestObj)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func back(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
}

//
//  TextEditorViewController.swift
//  Mobile Assistant
//
//  Created by RitcheldaV on 15/4/15.
//  Copyright (c) 2015 Cloudstaff. All rights reserved.
//

import UIKit

class TextEditorViewController: UIViewController {

    @IBOutlet weak var txtEditor: UITextView!
    @IBOutlet weak var navTitle: UINavigationItem!
    
    let prefs = NSUserDefaults.standardUserDefaults()
    
    
    ///////////////////////  KEYBOARD DISMISS  /////////////////////////
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    ////////////////////////////////////////////////////////////////////
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navTitle.title = prefs.stringForKey("TextEditor")
        
        if prefs.stringForKey("teValue") != "None" {
            txtEditor.text = prefs.stringForKey("teValue")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func done(sender: UIBarButtonItem) {
        if count(txtEditor.text) > 0 {
            prefs.setValue(txtEditor.text, forKey: "teValue")
        }
        navigationController?.popViewControllerAnimated(true)
    }
}

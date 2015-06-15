//
//  LoginSS.swift
//  SmartStaff
//
//  Created by RhoverF on 5/20/15.
//  Copyright (c) 2015 Cloudstaff. All rights reserved.
//

import UIKit
import Foundation

class LoginSS: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnForgot: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    

    
    override func viewDidLoad() {
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hideKeyboard")
        tapGesture.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tapGesture)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.deregisterFromKeyboardNotifications()
        super.viewWillDisappear(true)
        
    }
    
    
    func registerForKeyboardNotifications() -> Void {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func deregisterFromKeyboardNotifications() -> Void {
        println("Deregistering!")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification) {
        var info: Dictionary = notification.userInfo!
        var keyboardSize: CGSize = (info[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue().size)!
        var buttonOrigin: CGPoint = self.btnLogin.frame.origin;
        var buttonHeight: CGFloat = self.btnLogin.frame.size.height;
        var visibleRect: CGRect = self.view.frame
        visibleRect.size.height -= keyboardSize.height
        
        if (!CGRectContainsPoint(visibleRect, buttonOrigin)) {
            var scrollPoint: CGPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight + 4)
            self.scrollView.setContentOffset(scrollPoint, animated: true)
        }
    }

    func hideKeyboard() {
        txtEmail.resignFirstResponder()   //FirstResponder's must be resigned for hiding keyboard.
        txtPassword.resignFirstResponder()
        self.scrollView.setContentOffset(CGPointZero, animated: true)
    }
    
    @IBOutlet weak var login: UIScrollView!
    override func performSegueWithIdentifier(identifier: String?, sender: AnyObject?) {
        performSegueWithIdentifier("toStartupWizard", sender: self)
    }
    
    }
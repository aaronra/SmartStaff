//
//  AlertDialogs.swift
//  CloudstaffTeamManager
//
//  Created by t0tep on 3/13/15.
//  Copyright (c) 2015 CLOUDSTAFF. All rights reserved.
//

import UIKit
import Foundation

class AlertDialogs: NSObject, UIAlertViewDelegate {
    
    
    
    func alertLogin(apiMessage: String, viewController : UIViewController) {
        
        switch UIDevice.currentDevice().systemVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch) {
        case .OrderedSame, .OrderedDescending:
            println("8 above")
            var alertController = UIAlertController(title: "Code Detected", message: apiMessage, preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            })
            alertController.addAction(ok)
            viewController.presentViewController(alertController, animated: true, completion: nil)
        case .OrderedAscending:
            let alertView = UIAlertView(title: "Code Detected", message: apiMessage, delegate: self, cancelButtonTitle: "OK")
            alertView.alertViewStyle = .Default
            alertView.show()
            println("8 below")
            
        }
       
    }
    
///////  alertController for TableViewController with TextField --> SETTINGS /////////////
    
    
///////  alertController for TableViewController with TextField /////////////
    func showTableAlertController(viewController : UITableViewController) -> Void {
        var alertController = UIAlertController(title: "Enter Ping Message", message: "", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in})
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in}
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        alertController.addTextFieldWithConfigurationHandler { (name) -> Void in
            name.text = "Default Ping Message..!"
        }
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
///////  alertController for ViewController with TextField /////////////
    func showAlertController(viewController : UIViewController) -> Void {
        var alertController = UIAlertController(title: "Enter Ping Message", message: "", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in})
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in}
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        alertController.addTextFieldWithConfigurationHandler { (name) -> Void in
            name.text = "Default Ping Message..!"
        }
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func showAlertView() {
        var alert = UIAlertView()
        alert.delegate = self
        alert.title = "Enter Ping Message"
        alert.alertViewStyle = .PlainTextInput
        let textField = alert.textFieldAtIndex(0)
        alert.addButtonWithTitle("OK")
        textField?.text = "Default Ping Message"
        alert.addButtonWithTitle("Cancel")
        alert.show()
    }
    
    
    internal func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 0:
            println("OK \(buttonIndex)")
            break;
        case 1:
            println("CANCEL \(buttonIndex)")
            break;
        default: ()
        println("DEFAULT \(buttonIndex)")
        }
    }
    
}
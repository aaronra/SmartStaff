//
//  AppDelegate.swift
//  Mobile Assistant
//
//  Created by RitcheldaV on 20/3/15.
//  Copyright (c) 2015 Cloudstaff. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import QuartzCore


extension UIColor {
    convenience init(hex: Int) {
        let r = hex / 0x10000
        let g = (hex - r*0x10000) / 0x100
        let b = hex - r*0x10000 - g*0x100
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1)
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let prefs = NSUserDefaults.standardUserDefaults()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        println("PATH --->>> \(RLMRealm.defaultRealm().path)")

        UINavigationBar.appearance().barTintColor = UIColor(hex: 0x717171)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor(hex: 0xffffff)]
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        if let firstLoad = prefs.stringForKey("firstLoad") {
            println("This is NOT the first time to load the application" + firstLoad)
            
        } else {
//            prefs.setValue("Yes", forKey: "firstLoad")
            println("FIRST TIME")
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            var initialViewController = storyboard.instantiateViewControllerWithIdentifier("DisclaimerViewController") as! UIViewController
            
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
        prefs.setInteger(0, forKey: "selectedTile")
        prefs.setValue("", forKey: "selectedIcon")
        
        return true
    }

    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }

}


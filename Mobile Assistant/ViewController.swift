//
//  ViewController.swift
//  Mobile Assistant
//
//  Created by RitcheldaV on 20/3/15.
//  Copyright (c) 2015 Cloudstaff. All rights reserved.
//

import UIKit
import Darwin


class ViewController: UIViewController, SideBarDelegate, UIPageViewControllerDataSource, UINavigationControllerDelegate {
    
    // MARK: - Variables
    private var pageViewController: UIPageViewController?
    
    // Initialize it right away here
    private let contentImages = ["camera",
        "record",
        "text",
        "send",
        "assistant"];
    
    let pageTitles = ["One", "Two", "Three", "Four", "Five"]
    
    var sendOnTap = [true, false, true]
    var safetySend = [true, true, false]
    
    var sideBar:SideBar = SideBar()
    
    let prefs = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideBar = SideBar(sourceView: self.view, menuItems:
            ["Barcode Scanner",
                "backup",
                "restore",
                "settings",
                "help",
                "disclaimer",
                "about this app",
                "about cloudstaff",
                "exit"])
        sideBar.delegate = self
        
        createPageViewController()
        setupPageControl()
        
        self.navigationItem.title = pageTitles[0]
    }
    
    private func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        pageController.dataSource = self
        
        if contentImages.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers: NSArray = [firstController]
            pageController.setViewControllers(startingViewControllers as [AnyObject], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        
        pageViewController!.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - 70)
        
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.lightGrayColor()
        appearance.currentPageIndicatorTintColor = UIColor.darkGrayColor()
        appearance.backgroundColor = UIColor.whiteColor()
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        
        self.navigationItem.title = pageTitles[itemController.itemIndex]
        
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        
        self.navigationItem.title = pageTitles[itemController.itemIndex]
        
        if itemController.itemIndex+1 < contentImages.count {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }
    
    
    private func getItemController(itemIndex: Int) -> PageItemController? {
        
        if itemIndex < contentImages.count {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("ItemController") as! PageItemController
            pageItemController.itemIndex = itemIndex
//            pageItemController.imageName = contentImages[itemIndex]
            
            return pageItemController
        }
        
        return nil
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return contentImages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    @IBAction func showMenu(sender: AnyObject) {
        if sideBar.isSideBarOpen == true {
            sideBar.showSideBar(false)
        }else{
            sideBar.showSideBar(true)
        }
    }
    
    func sideBarDidSelectButtonAtIndex(index: Int) {
        if index == 0{
            sideBar.showSideBar(false)
        } else if index == 1 {
            sideBar.showSideBar(false)
            println("second")
        } else if index == 2 {
            performSegueWithIdentifier("toGeneralSettings", sender: self)
            sideBar.showSideBar(false)
        } else if index == 3 {
            performSegueWithIdentifier("toHelp", sender: self)
            sideBar.showSideBar(false)
            println("fourth")
        } else if index == 4 {
            performSegueWithIdentifier("toDisclaimer", sender: self)
            sideBar.showSideBar(false)
            println("fifth")
        } else if index == 5 {
            performSegueWithIdentifier("toAboutApp", sender: self)
            sideBar.showSideBar(false)
            println("fourth")
        } else if index == 6 {
            performSegueWithIdentifier("toAboutCloudstaff", sender: self)
            sideBar.showSideBar(false)
            println("fifth")
        } else if index == 7 {
            exit(0)
        }
    }
    
    @IBAction func record_up(sender: UIButton) {
        sender.setImage(UIImage(named: "record"), forState: UIControlState.Normal)
    }
    
    
    @IBAction func record_down(sender: UIButton) {
        sender.setImage(UIImage(named: "recordonclick"), forState: UIControlState.Highlighted)
    }
    
    @IBAction func camera_up(sender: UIButton) {
        sender.setImage(UIImage(named: "camera"), forState: UIControlState.Normal)
    }
    
    
    @IBAction func camera_down(sender: UIButton) {
        sender.setImage(UIImage(named: "cameraonclick"), forState: UIControlState.Highlighted)
    }
    
    @IBAction func text_up(sender: UIButton) {
        sender.setImage(UIImage(named: "text"), forState: UIControlState.Normal)
    }
    
    @IBAction func text_down(sender: UIButton) {
        sender.setImage(UIImage(named: "textonclick"), forState: UIControlState.Highlighted)
    }
    
    @IBAction func send_up(sender: UIButton) {
//        sender.setImage(UIImage(named: "send"), forState: UIControlState.Normal)
    }
    
    @IBAction func send_down(sender: UIButton) {
//        sender.setImage(UIImage(named: "sendonclick"), forState: UIControlState.Highlighted)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toGeneralSettings" {
//            let gsettingsVController : GSettingsTableViewController = segue.destinationViewController as GSettingsTableViewController

        }
    }

    @IBAction func audioRecord(sender: UIButton) {
        println("Record and Audio")
    }

    @IBAction func takePhoto(sender: UIButton) {
        println("Take a Photo")
    }

    @IBAction func editText(sender: UIButton) {
        println("Added Subject Content")
    }

    @IBAction func sendNow(sender: UIButton) {
        println(prefs.integerForKey("selectedTile"))
        if prefs.integerForKey("selectedTile") != 0 {
            if safetySend[prefs.integerForKey("selectedTile")] {
                let optionMenu = UIAlertController(title: "Safety Send", message: "Are you sure you want to send this message to {Cloudstaffer}?", preferredStyle: UIAlertControllerStyle.ActionSheet)
                
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                    
                    (alert: UIAlertAction!) -> Void in
                    
                    self.view.makeToast(message: "Sent!")
                    self.view.makeToastActivity()
                    
                    
                })
                
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {
                    
                    (alert: UIAlertAction!) -> Void in
                    
                    println("Cancelled")
                    
                })
                
                optionMenu.addAction(okAction)
                optionMenu.addAction(cancelAction)
                
                self.presentViewController(optionMenu, animated: true, completion: nil)
            } else {
                self.view.makeToast(message: "Sent!")
            }
        }
        
    }
}



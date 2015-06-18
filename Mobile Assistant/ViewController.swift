//
//  ViewController.swift
//  Mobile Assistant
//
//  Created by RitcheldaV on 20/3/15.
//  Copyright (c) 2015 Cloudstaff. All rights reserved.
//

import UIKit
import Darwin
import CoreData
import CoreLocation
import AVFoundation
import SpriteKit
import MessageUI

class ViewController: UIViewController, SideBarDelegate, UIPageViewControllerDataSource, UINavigationControllerDelegate, NSFetchedResultsControllerDelegate, UIImagePickerControllerDelegate, AVAudioRecorderDelegate,UIActionSheetDelegate {
    
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
    var audioRecorder:AVAudioRecorder!
    
    var sideBar:SideBar = SideBar()
    
    let prefs = NSUserDefaults.standardUserDefaults()
    
    // set by AppDelegate on application startup
    var managedObjectContext: NSManagedObjectContext?
    
    /* `NSFetchedResultsController`
    lazily initialized
    fetches the displayed domain model */
    var fetchedResultsController: NSFetchedResultsController {
        // return if already initialized
        if self._fetchedResultsController != nil {
            return self._fetchedResultsController!
        }
        
    
        let managedObjectContext = self.managedObjectContext!
        
        var audioRecorder:AVAudioRecorder!
        
        /* `NSFetchRequest` config
        fetch all `Item`s
        order them alphabetically by name
        at least one sort order is required */
        let entity = NSEntityDescription.entityForName("Pages", inManagedObjectContext: managedObjectContext)
        let sort = NSSortDescriptor(key: "id", ascending: true)
        let req = NSFetchRequest()
        req.entity = entity
        req.sortDescriptors = [sort]
        
        /* NSFetchedResultsController initialization
        a `nil` `sectionNameKeyPath` generates a single section */
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: req, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        self._fetchedResultsController = aFetchedResultsController
        
        // perform initial model fetch
        var e: NSError?
        if !self._fetchedResultsController!.performFetch(&e) {
            println("fetch error: \(e!.localizedDescription)")
            abort();
        }
        
        return self._fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideBar = SideBar(sourceView: self.view, menuItems:
            ["Backup",
                "Restore",
                "Settings",
                "Help",
                "DISCLAIMER",
                "About this App",
                "Exit"])
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
        var inputTextField: UITextField?
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Backup Code", message: "All templates have been saved on cloud servers, you can use the following code to restore them.", preferredStyle: .Alert)
        
        
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            //Do some other stuff
        }
        actionSheetController.addAction(nextAction)
        //Add a text field
        actionSheetController.addTextFieldWithConfigurationHandler { textField -> Void in
            // you can use this text field
            inputTextField = textField
        }
        
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        } else if index == 1 {
            sideBar.showSideBar(false)
        var inputTextField: UITextField?
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Restore", message: "Please enter the code to get your templates back", preferredStyle: .Alert)
        
        
        //Create and an option action
        let Ok: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            //Do some other stuff
        }
        let Cancel = UIAlertAction(title: "Cancel", style: .Default, handler: { (action) -> Void in
        })
        
        actionSheetController.addAction(Ok)
        actionSheetController.addAction(Cancel)
        
        //Add a text field
        actionSheetController.addTextFieldWithConfigurationHandler { textField -> Void in
            // you can use this text field
            inputTextField = textField
        }
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)

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
    
    
        
    
    //
//            var audioSession:AVAudioSession = AVAudioSession.sharedInstance()
//            audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
//            audioSession.setActive(true, error: nil)
//            
//            var documents: AnyObject = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory,  NSSearchPathDomainMask.UserDomainMask, true)[0]
//            var str =  documents.stringByAppendingPathComponent("")
//            var url = NSURL.fileURLWithPath(str as String)
//            
//            var recordSettings = [AVFormatIDKey:kAudioFormatAppleIMA4,
//                AVSampleRateKey:44100.0,
//                AVNumberOfChannelsKey:2,AVEncoderBitRateKey:12800,
//                AVLinearPCMBitDepthKey:16,
//                AVEncoderAudioQualityKey:AVAudioQuality.Max.rawValue
//                
//            ]
//            
//            println("url : \(url)")
//            var error: NSError?
//            
//            audioRecorder = AVAudioRecorder(URL:url, settings: recordSettings as [NSObject : AnyObject] , error: &error)
//            if let e = error {
//                println(e.localizedDescription)
//            } else {
//                
//                audioRecorder.record()
//            }
        
  
    
    
   var imagePicker = UIImagePickerController()
    var image = UIImage()
    
    @IBAction func takePhoto(sender: AnyObject) {
        
        let title = "Choose an Action"
        let message = ""
        let optionOneText = "Barcode Scanner"
        let optionTwoText = "Camera"
        let cancelButtonTitle = "Cancel"
        
        let actionsheet = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let BarcodeButton = UIAlertAction(title: optionOneText, style: UIAlertActionStyle.Default) { (BarcodeScannerSelected) -> Void in
            self.performSegueWithIdentifier("toBarcodeScanner", sender: self)
        }
        let Camera =  UIAlertAction(title: optionTwoText, style: UIAlertActionStyle.Default) { (CameraSelected) -> Void in
            
            UIImagePickerController.isSourceTypeAvailable(.Camera)
            var picker : UIImagePickerController = UIImagePickerController()
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            self.imagePicker.allowsEditing = false
            
            //            let image = UIGraphicsGetImageFromCurrentImageContext()
            //            UIGraphicsEndImageContext()
            //            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
            
            
            println("take a photo")
            
        }
        let Cancel = UIAlertAction(title: cancelButtonTitle, style: UIAlertActionStyle.Cancel){ (CancelSelected) -> Void in
            
        }
        
        actionsheet.addAction(BarcodeButton)
        
        actionsheet.addAction(Camera)
        
        actionsheet.addAction(Cancel)
        
        self.presentViewController(actionsheet, animated: true, completion: nil)
    
    }
    
    
    @IBAction func editText(sender: UIButton) {
        var inputTextField: UITextField?
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Add Message Text", message: "Enter a short comment which will be added to your message: ", preferredStyle: .Alert)
        
    
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            //Do some other stuff
        }
        actionSheetController.addAction(nextAction)
        //Add a text field
        actionSheetController.addTextFieldWithConfigurationHandler { textField -> Void in
            // you can use this text field
            inputTextField = textField
        }
    
    
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
           }
 
 
    @IBAction func Map(sender: AnyObject) {
        performSegueWithIdentifier("toMapview", sender: self)
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


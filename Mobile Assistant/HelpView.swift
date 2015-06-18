//
//  File.swift
//  SmartStaff
//
//  Created by RhoverF on 6/18/15.
//  Copyright (c) 2015 Cloudstaff. All rights reserved.
//

import Foundation
import UIKit


class HelpView: UIViewController, UIPageViewControllerDataSource, UINavigationControllerDelegate {
    
    
    private var pageViewController: UIPageViewController?
    let prefs = NSUserDefaults.standardUserDefaults()
    
    // Initialize it right away here
    private let contentImages = ["help1",
        "help2",
        "help3"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let firstLoad = prefs.stringForKey("firstLoad") {
            println("This is NOT the first time to load the application" + firstLoad)
        } else {
            prefs.setValue("Yes", forKey: "firstLoad")
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Skip", style: UIBarButtonItemStyle.Bordered, target: self, action: "skip:")
        }
        
        createPageViewController()
        setupPageControl()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func skip(sender: UIBarButtonItem) {
        performSegueWithIdentifier("toTiles", sender: self)
    }
    
    private func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("HelpPageController") as! UIPageViewController
        pageController.dataSource = self
        
        if contentImages.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers: NSArray = [firstController]
            pageController.setViewControllers(startingViewControllers as [AnyObject], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        
        pageViewController!.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        
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
        
        let itemController = viewController as! HelpItemController
        
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! HelpItemController
        
        if itemController.itemIndex+1 < contentImages.count {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }
    
    
    
    private func getItemController(itemIndex: Int) -> HelpItemController? {
        
        if itemIndex < contentImages.count {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("HelpItemController") as! HelpItemController
            pageItemController.itemIndex = itemIndex
            pageItemController.imageName = contentImages[itemIndex]
            
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
}

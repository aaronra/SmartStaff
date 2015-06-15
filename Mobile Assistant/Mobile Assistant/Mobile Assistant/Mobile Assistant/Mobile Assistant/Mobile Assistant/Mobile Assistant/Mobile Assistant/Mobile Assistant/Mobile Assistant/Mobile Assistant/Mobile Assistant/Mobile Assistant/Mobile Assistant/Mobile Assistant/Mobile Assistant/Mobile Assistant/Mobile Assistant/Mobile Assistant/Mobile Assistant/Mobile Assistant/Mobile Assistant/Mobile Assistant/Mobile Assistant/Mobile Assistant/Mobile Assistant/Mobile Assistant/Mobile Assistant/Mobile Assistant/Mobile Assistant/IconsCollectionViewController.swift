//
//  IconsCollectionViewController.swift
//  Mobile Assistant
//
//  Created by RitcheldaV on 10/4/15.
//  Copyright (c) 2015 Cloudstaff. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class IconsCollectionViewController: UICollectionViewController {
    
    let icons = ["action_this_voice_memo", "add_to_contacts_and_linkedin", "add_to_contacts", "airline_reservation", "banking", "boarding_pass", "call_me_about_this", "coffee", "credit_card_purchase", "document_this", "drinks", "drive", "emergency", "expense", "food", "hotel", "legal_services", "make_into_ppt", "meeting", "password", "pharmacy", "printer", "question", "research_this_product", "restaurant_reservation", "scanner", "schedule", "termination", "transcript_voice_recording", "type_this_for_me", "website_update", "workstation"]
    
    let prefs = NSUserDefaults.standardUserDefaults()

    var selectedIcon = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func done(sender: UIBarButtonItem) {
        prefs.setValue(selectedIcon, forKey: "selectedIcon")
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        println("prepareForSegue")
        
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("iconCell", forIndexPath: indexPath) as! IconCell
        
        cell.btnIcon.tag = indexPath.row
        
        if icons[indexPath.row] == selectedIcon {
            cell.btnIcon.setImage(UIImage(named: icons[indexPath.row] + "_select"), forState: UIControlState.Normal)
        } else {
            cell.btnIcon.setImage(UIImage(named: icons[indexPath.row]), forState: UIControlState.Normal)
        }
        cell.btnIcon.addTarget(self, action: "iconSelected:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        return cell
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func iconSelected(sender:UIButton) {
        
        let rowIndex = sender.tag
        
        selectedIcon = icons[rowIndex]
       
        sender.setImage(UIImage(named: icons[rowIndex] + "_select"), forState: UIControlState.Normal)
        
        println("pressed!")
        
        collectionView!.reloadData()
    }

}

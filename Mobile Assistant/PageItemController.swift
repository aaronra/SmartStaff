//
//  PageItemController.swift
//  Mobile Assistant
//
//  Created by RitcheldaV on 20/3/15.
//  Copyright (c) 2015 Cloudstaff. All rights reserved.
//

import UIKit

class PageItemController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var selectedTile = 0
    var itemIndex: Int = 0
    var tileTitle = ["Call Me About This", "Hotel", "Legal Services"]
    var tileIcon = ["call_me_about_this", "hotel", "legal_services"]
    let pageTitles = ["One", "Two", "Three", "Four", "Five"]
    var tileId = [1,2,3]
    var sendOnTap = [true, false, true]
    var safetySend = [true, true, false]
    
    var longPressTarget: (cell: UICollectionViewCell, indexPath: NSIndexPath)!
    var longPressTargetIndex: Int = 0
    
    let prefs = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: "longPressHandler:")
        collectionView.addGestureRecognizer(longPress)
        
        selectedTile = prefs.integerForKey("selectedTile")
        
        tileIcon.append("add_new_tile_icon")
        tileTitle.append("Add New Tile")
        tileId.append(0)
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tileTitle.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("tileCell", forIndexPath: indexPath) as! TileCell
        
        cell.imgTile.image = UIImage(named: tileIcon[indexPath.row])
        
        if tileId[indexPath.row] == selectedTile {
            if selectedTile != 0 {
                cell.imgTile.image = UIImage(named: tileIcon[indexPath.row] + "_select")
            }
        }
        
        cell.lblTile.text = tileTitle[indexPath.row]
        cell.tag = tileId[indexPath.row]
        
        prefs.setInteger(selectedTile, forKey: "selectedTile")
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("Clicked!")
    
        if indexPath.row == (tileIcon.count-1) {
            prefs.setBool(true, forKey: "newTile")
            self.performSegueWithIdentifier("toTileSettings", sender: self)
        } else {
            if sendOnTap[indexPath.row] {
                if safetySend[indexPath.row] {
                    let optionMenu = UIAlertController(title: "Safety Send", message: "Are you sure you want to send this message to {Cloudstaffer}?", preferredStyle: UIAlertControllerStyle.ActionSheet)
                    
                    
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                        
                        (alert: UIAlertAction!) -> Void in
                        
                        self.view.makeToast(message: "Sent!")
                        
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
            
            prefs.setBool(false, forKey: "newTile")
        }
        
        selectedTile = tileId[indexPath.row]
        prefs.setInteger(tileId[indexPath.row], forKey: "selectedTile")
        collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        println("UnHIGHLIGHT!")
        
        selectedTile = tileId[indexPath.row]
        prefs.setInteger(tileId[indexPath.row], forKey: "selectedTile")
        collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath){
        println("Tapped!")
        
        longPressTarget = (cell: self.collectionView(collectionView, cellForItemAtIndexPath: indexPath), indexPath: indexPath)
        
    }
    
    
    func longPressHandler(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.Began {
            println("Long Pressed!")

            
            if let _longPressTarget = longPressTarget {
                longPressTargetIndex = _longPressTarget.indexPath.row
                
            let optionMenu = UIAlertController(title: tileTitle[longPressTargetIndex], message: "This tile will send to: Cloudstaff(er), SMS, Email.", preferredStyle: UIAlertControllerStyle.ActionSheet)
                
            let deleteAtion = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Destructive, handler: {
            
                (alert: UIAlertAction!) -> Void in
                
                self.deleteTile()
                
                UITableViewCellEditingStyle.Delete
            })
                
              
            let moveAction = UIAlertAction(title: "Move", style: UIAlertActionStyle.Default, handler: {
                
                (alert: UIAlertAction!) -> Void in
                
                self.moveTileToPage()
                
            })
                
            
            let editAction = UIAlertAction(title: "Edit", style: UIAlertActionStyle.Default, handler: {
                
                (alert: UIAlertAction!) -> Void in
                
                self.performSegueWithIdentifier("toTileSettings", sender: self)
                
            })
                
             
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {
                
                (alert: UIAlertAction!) -> Void in
                
                println("Cancelled")
                
            })
                
                
                
            optionMenu.addAction(deleteAtion)
            optionMenu.addAction(moveAction)
            optionMenu.addAction(editAction)
            optionMenu.addAction(cancelAction)
                
            self.presentViewController(optionMenu, animated: true, completion: nil)
            
            }
        }
    }
    
    func moveTileToPage() {
        let optionMenu = UIAlertController(title: "Move This Tile", message: "Choose which page or group you want to move this tile.", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let firstAtion = UIAlertAction(title: pageTitles[0], style: UIAlertActionStyle.Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            println("Moved to Page 1")
        })
        
        let secondAction = UIAlertAction(title: pageTitles[1], style: UIAlertActionStyle.Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            println("Moved to Page 2")
        })
        
        
        let thirdAction = UIAlertAction(title: pageTitles[2], style: UIAlertActionStyle.Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            println("Moved to Page 3")
        })
        
        
        let fourthAction = UIAlertAction(title: pageTitles[3], style: UIAlertActionStyle.Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            println("Moved to Page 4")
        })
        
        
        let fifthAction = UIAlertAction(title: pageTitles[4], style: UIAlertActionStyle.Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            println("Moved to Page 5")
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
            println("Cancelled")
        })
        
        
        optionMenu.addAction(firstAtion)
        optionMenu.addAction(secondAction)
        optionMenu.addAction(thirdAction)
        optionMenu.addAction(fourthAction)
        optionMenu.addAction(fifthAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    
    func deleteTile() {
        let optionMenu = UIAlertController(title: "Delete This Tile", message: "Are you sure you want to delete tile permanently?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let yesAtion = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            
            println("Deleted Tile!")
        })
        
        let noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            println("Cancelled!")
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
            println("Cancelled")
        })
        
        
        optionMenu.addAction(yesAtion)
        optionMenu.addAction(noAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }

}

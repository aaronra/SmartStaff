//
//  PhotoLibrary.swift
//  SmartStaff
//
//  Created by RhoverF on 6/22/15.
//  Copyright (c) 2015 Cloudstaff. All rights reserved.
//

import Foundation
import UIKit
import Photos

let ReuseIdentifier = "PhotoCell"
let albumName = "App Folder"

class PhotoLibrary: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    var albumFound : Bool = false
    var assetCollection: PHAssetCollection!
    var photosAsset: PHFetchResult!
    var assetThumbnailSize:CGSize!
    
    @IBAction func bcktoMain(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func btnCamera(sender: AnyObject) {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            //load the camera interface
            var picker : UIImagePickerController = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.delegate = self
            picker.allowsEditing = false
            self.presentViewController(picker, animated: true, completion: nil)
        }else{
            //no camera available
            var alert = UIAlertController(title: "Error", message: "There is no camera available", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: {(alertAction)in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }

    }
    
    @IBAction func btnPhotoAlbum(sender: AnyObject) {
        var picker : UIImagePickerController = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.PhotoLibrary)!
        picker.delegate = self
        picker.allowsEditing = false
        self.presentViewController(picker, animated: true, completion: nil)

    }
 

    @IBAction func SendPhotos(sender: AnyObject) {
        
    }
    
    @IBOutlet var noPhotosLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check if the folder exists, if not, create it
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let collection:PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fetchOptions)
        
        if let first_Obj:AnyObject = collection.firstObject{
            //found the album
            self.albumFound = true
            self.assetCollection = first_Obj as! PHAssetCollection
        }else{
            //Album placeholder for the asset collection, used to reference collection in completion handler
            var albumPlaceholder:PHObjectPlaceholder!
            //create the folder
            NSLog("\nFolder \"%@\" does not exist\nCreating now...", albumName)
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                let request = PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(albumName)
                albumPlaceholder = request.placeholderForCreatedAssetCollection
                },
                completionHandler: {(success:Bool, error:NSError!)in
                    if(success){
                        println("Successfully created folder")
                        self.albumFound = true
                        if let collection = PHAssetCollection.fetchAssetCollectionsWithLocalIdentifiers([albumPlaceholder.localIdentifier], options: nil){
                            self.assetCollection = collection.firstObject as! PHAssetCollection
                        }
                    }else{
                        println("Error creating folder")
                        self.albumFound = false
                    }
            })
        }
    }

    override func viewWillAppear(animated: Bool) {
        println("ViewWillAppear")
        
        // Get size of the collectionView cell for thumbnail image
        let scale:CGFloat = UIScreen.mainScreen().scale
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            let cellSize = layout.itemSize
            self.assetThumbnailSize = CGSizeMake(cellSize.width, cellSize.height)
        }
        
        //fetch the photos from collection
        self.navigationController?.hidesBarsOnTap = false   //!! Use optional chaining
        self.photosAsset = PHAsset.fetchAssetsInAssetCollection(self.assetCollection, options: nil)
        
        if let photoCnt = self.photosAsset?.count{
            if(photoCnt == 0){
                self.noPhotosLabel.hidden = false
            }else{
                self.noPhotosLabel.hidden = true
            }
        }
        self.collectionView.reloadData()
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "viewLargePhoto"){
            if let controller:ViewPhoto = segue.destinationViewController as? ViewPhoto{
                if let cell = sender as? UICollectionViewCell{
                    if let indexPath: NSIndexPath = self.collectionView.indexPathForCell(cell){
                        controller.index = indexPath.item
                        controller.photosAsset = self.photosAsset
                        controller.assetCollection = self.assetCollection
                    }
                }
            }
        }
    }
    

    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        var count: Int = 0
        if(self.photosAsset != nil){
            count = self.photosAsset.count
        }
        return count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell: PhotoThumbnail = collectionView.dequeueReusableCellWithReuseIdentifier(ReuseIdentifier, forIndexPath: indexPath) as! PhotoThumbnail
        
        //Modify the cell
        let asset: PHAsset = self.photosAsset[indexPath.item] as! PHAsset
        
        // Create options for retrieving image (Degrades quality if using .Fast)
        //        let imageOptions = PHImageRequestOptions()
        //        imageOptions.resizeMode = PHImageRequestOptionsResizeMode.Fast
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: self.assetThumbnailSize, contentMode: .AspectFill, options: nil, resultHandler: {(result, info)in
            cell.setThumbnailImage(result)
        })
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 4
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 1
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
        if let image: UIImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            
            //Implement if allowing user to edit the selected image
            //let editedImage = info.objectForKey("UIImagePickerControllerEditedImage") as UIImage
            
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0), {
                PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                    let createAssetRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(image)
                    let assetPlaceholder = createAssetRequest.placeholderForCreatedAsset
                    let albumChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: self.assetCollection, assets: self.photosAsset)
                    albumChangeRequest.addAssets([assetPlaceholder])
                    }, completionHandler: {(success, error)in
                        dispatch_async(dispatch_get_main_queue(), {
                            NSLog("Adding Image to Library -> %@", (success ? "Sucess":"Error!"))
                            picker.dismissViewControllerAnimated(true, completion: nil)
                        })
                })
                
            })
        }
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

}

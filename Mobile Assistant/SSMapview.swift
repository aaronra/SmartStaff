//
//  SSMapview.swift
//  SmartStaff
//
//  Created by RhoverF on 5/27/15.
//  Copyright (c) 2015 Cloudstaff. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit
import QuartzCore
import MessageUI


class SSMapView: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, MFMailComposeViewControllerDelegate {
    
    var coreLocationManager = CLLocationManager()
    
    var locationManager: LocationManager!
    
    @IBOutlet weak var Map: MKMapView!

    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coreLocationManager.delegate = self
        
        locationManager = LocationManager.sharedInstance
        
        let authorizationCode = CLLocationManager.authorizationStatus()
        
        if authorizationCode == CLAuthorizationStatus.NotDetermined && coreLocationManager.respondsToSelector("requestAlwaysAuthorization") || coreLocationManager.respondsToSelector("requestWhenInUseAuthorization"){
            if NSBundle.mainBundle().objectForInfoDictionaryKey("NSLocationAlwaysUsageDescription") != nil {
                coreLocationManager.requestAlwaysAuthorization()
                Map.showsUserLocation = true
            }else{
                println("no description provided")
            }
        }else{
            getLocation()
        }
    }
    
    
    @IBAction func Backmain(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
       
    }
    
    func getLocation() {
        locationManager.startUpdatingLocationWithCompletionHandler { (latitude, longitude, status, verboseMessage, error) -> () in
            self.displayLocation(CLLocation(latitude: latitude, longitude: longitude))
        }
        
    }
    func displayLocation(location:CLLocation){
        
        Map.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude), span: MKCoordinateSpanMake(0.05, 0.05)), animated: true)
        
        let locationPinCoord = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationPinCoord
        
        Map.addAnnotation(annotation)
        Map.showAnnotations([annotation], animated: true)
        
        locationManager.reverseGeocodeLocationWithCoordinates(location, onReverseGeocodingCompletionHandler: { (reverseGecodeInfo, placemark, error) -> Void in
            println(reverseGecodeInfo)
        })
        
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status != CLAuthorizationStatus.NotDetermined || status != CLAuthorizationStatus.Denied || status != CLAuthorizationStatus.Restricted{
            
            getLocation()
            
        }
        
    }

    @IBAction func Screenshot(sender: AnyObject) {
        
        
        

        
        let layer = UIApplication.sharedApplication().keyWindow!.layer
        let scale = UIScreen.mainScreen().scale
        println(scale)
        
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale - 2.0);
        layer.renderInContext(UIGraphicsGetCurrentContext())
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
        
        let screenShot = UIImage(named: "someImage")
        if let unwrappedImage = screenshot {
            let data = UIImageJPEGRepresentation(unwrappedImage, 1.0)
        }
        
        }
        
        
    }
    
       
        
        
            
            
        

      
    



    
    

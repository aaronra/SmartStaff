//
//  APIFunctions.swift
//  SmartStaff
//
//  Created by t0tep on 6/16/15.
//  Copyright (c) 2015 Cloudstaff. All rights reserved.
//

import Foundation


public class APIFunctions {
    
    
    class func postLogin(params : Dictionary<String, AnyObject!>, url : String, postCompleted : (code: Int, msg: String) -> ()) {
        
        
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        var err: NSError?
        var bodyData = ""
        
        for param in params {
            bodyData += "\(param.0)=\(param.1)&"
        }
        
        println(bodyData)
        
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
        
        var task = session.dataTaskWithRequest(request, completionHandler: { data, response, error -> Void in
            println("Response: \(response)")
            
            
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println(strData!)
            
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves, error: &err) as? NSDictionary
            
            var msg = "No message"
            
            if(err != nil) {
                println("Error--->>>>> \(err!.localizedDescription)")
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: \(jsonStr!.description)")
                postCompleted(code: 500, msg: "Please try Again later.")
                
            }else {
                
                if let parseJSON = json {
                    let code = parseJSON["code"] as? Int
                    var message = parseJSON["message"] as? String
                    
                    postCompleted(code: code!, msg: message!)

                    
                }else {
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                    postCompleted(code: 500, msg: "Please try Again later.")
                }
            }
            
        })
        
        task.resume()
    }
    
}

//
//  HelpItemController.swift
//  Mobile Assistant
//
//  Created by RitcheldaV on 30/3/15.
//  Copyright (c) 2015 Cloudstaff. All rights reserved.
//

import UIKit

class HelpItemController: UIViewController {

    var itemIndex: Int = 0
        var imageName: String = "" {
    
            didSet {
    
                if let imageView = contentImageView {
                    imageView.image = UIImage(named: imageName)
                }
    
            }
        }
    
    @IBOutlet var contentImageView: UIImageView?
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentImageView!.image = UIImage(named: imageName)
        
        if itemIndex == 2 {
            startButton.setTitle("Let's get started!", forState: UIControlState.Normal)
            startButton.titleLabel!.font = UIFont(name: "System", size: 20.0)
        }
        
    }
    
    @IBAction func back(sender: UIButton) {
        performSegueWithIdentifier("toTiles", sender: self)
    }

}

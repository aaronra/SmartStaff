//
//  PhotoThumbnail.swift
//  SmartStaff
//
//  Created by RhoverF on 6/22/15.
//  Copyright (c) 2015 Cloudstaff. All rights reserved.
//

import UIKit

class PhotoThumbnail: UICollectionViewCell {
    
    @IBOutlet var imgView: UIImageView!
    
    func setThumbnailImage(thumbnailImage: UIImage){
        self.imgView.image = thumbnailImage
    }

}

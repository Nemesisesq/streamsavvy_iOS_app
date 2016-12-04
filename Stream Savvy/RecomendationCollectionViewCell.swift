//
//  RecomendationCollectionViewCell.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 12/2/16.
//  Copyright © 2016 StreamSavvy. All rights reserved.
//

import UIKit

class RecomendationCollectionViewCell: UICollectionViewCell {
    var content : Content! {
        didSet{
            if content.image_link != nil{
                showImage.sd_setImage(with: URL(string: content.image_link))
            }
        }
    }
    @IBOutlet var showImage: UIImageView!
    
}

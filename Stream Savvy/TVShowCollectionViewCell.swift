//
//  GuideCollectionViewCell.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/24/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit
import MarqueeLabel

class TVSetUpCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imgView: UIImageView!
    var fav: Bool! = false
       
    
    var popularShow: PopularShow!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
}

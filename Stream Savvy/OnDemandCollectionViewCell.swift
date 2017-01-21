//
//  GuideCollectionViewCell.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/24/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit
import MarqueeLabel
import Dollar


class OnDemandCollectionViewCell: UICollectionViewCell {
    
    var favorites:Favorites!

    @IBOutlet var checkmark: UIImageView! {
        didSet {
            if let x  = checkmark.image{
                
                checkmark.image = x.withRenderingMode(.alwaysTemplate)
                checkmark.tintColor = Constants.streamSavvyRed()
            }
        }
    }
    @IBOutlet var imgView: UIImageView!
    //    @IBOutlet var titleLable: MarqueeLabel!
    @IBOutlet var gradientMask: UIView!
    
    var fav: Bool! = false {
        didSet{
            
            
            if let x  = checkmark.image{
                
                checkmark.image = x.withRenderingMode(.alwaysTemplate)
                checkmark.tintColor = Constants.streamSavvyRed()
            }
            
            if fav == true {
                self.checkmark.isHidden = false
            } else {
                self.checkmark.isHidden = true
            }
            
        }
    }
    
    
    var popularShow: PopularShow!

    override func awakeFromNib() {
        super.awakeFromNib()
        let gradient = Common().linearGradentTopToBottom()
        gradient.frame = self.bounds
        self.imgView.layer.insertSublayer(gradient, at: 0)
        
    }
    
    
    
}

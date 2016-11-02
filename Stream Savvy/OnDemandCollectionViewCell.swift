//
//  GuideCollectionViewCell.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/24/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit
import MarqueeLabel

class OnDemandCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var titleLable: MarqueeLabel!
    @IBOutlet var gradientMask: UIView!
    
    var popularShow: PopularShow!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let gradient = Common().linearGradentTopToBottom()
        gradient.frame = self.bounds
        self.imgView.layer.insertSublayer(gradient, at: 0)

    }
    

}

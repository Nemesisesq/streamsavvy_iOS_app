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
        
        var popularShow: PopularShow!
    
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		Constants.addGradient(for: imgView)

	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
//		fatalError("init(coder:) has not been implemented")
		Constants.addGradient(for: imgView)

	}
}

//
//  CarouselItem.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/7/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit

class CarouselItem: UIView {
        
        
        @IBOutlet var showTitle: UILabel!
        
        @IBOutlet var showImage: UIImageView!
        
        @IBAction func watchEpisode(_ sender: UIButton) {
                self.performSegue(withIdentifier: "EpisodeSegue", sender: self)

        }
        
//        override init(frame: CGRect) {
//                super.init(frame: frame)
//                UINib(nibName: "CarouselItem", bundle: nil).instantiate(withOwner: self, options: nil)
//                      }
//        
//        required init?(coder aDecoder: NSCoder) {
//                super.init(coder: aDecoder)
//                UINib(nibName: "CarouselItem", bundle: nil).instantiate(withOwner: self, options: nil)
//        }
        
        class func instantiateFromNib() -> CarouselItem {
                let view = UINib(nibName: "CarouselItem", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CarouselItem
                
                return view
        }
}

//
//  CarouselItem.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/7/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit

class CarouselItem: UIView {

        @IBOutlet var showImage: UIImageView!
        @IBOutlet var showTitle: UILabel!
        
        @IBAction func watchEpisodes(_ sender: AnyObject) {
        }
        @IBAction func share(_ sender: AnyObject) {
        }
        
        
        @IBOutlet var likeButton: UIButton!
        @IBAction func toggleLike(_ sender: UIButton) {
        }
        
        required init?(coder aDecoder: NSCoder) {
                super.init(coder: aDecoder)
                UINib(nibName: "CarouselItem", bundle: nil).instantiate(withOwner: self, options: nil)
        
        }

}

//
//  CarouselItem.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/7/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit

class CarouselItem: UIView {

        @IBOutlet var likeButtonStatus: UIButton!
        
        var vc: FavoritesViewController!
        
        var index: Int!
        
        @IBOutlet var showTitle: UILabel!
        
        @IBOutlet var showImage: UIImageView!
        
        @IBAction func toggleLikeButton(_ sender: UIButton) {
                vc.favorites.contentList.remove(at: index)
                likeButtonStatus.imageView?.image = #imageLiteral(resourceName: "Like-50")
                vc.carousel.reloadData()
                
        }
        
        @IBAction func Share(_ sender: AnyObject) {
        }
        
        @IBAction func watchEpisode(_ sender: UIButton) {
                vc.performSegue(withIdentifier: "EpisodeSegue", sender: self)

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

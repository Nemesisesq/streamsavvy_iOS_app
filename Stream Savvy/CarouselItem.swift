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
        
        @IBOutlet var share: UIButton!
        
        
        var vc: FavoritesViewController!
        
        var index: Int!
        
        var content: Content!
        
        @IBOutlet var showTitle: UILabel!
        
        @IBOutlet var showImage: UIImageView!
        
        @IBAction func toggleLikeButton(_ sender: UIButton) {
                vc.favorites.removeContentFromFavorites(content: content)
                        
                        .then {result -> Void in
                                
                                self.vc.favorites.contentList.remove(at: self.index)
                                self.likeButtonStatus.imageView?.image = #imageLiteral(resourceName: "Like-50")
                                self.vc.carousel.reloadData()

                                
                }
                
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
                
                
                view.share.removeFromSuperview()
                
                return view
        }
}

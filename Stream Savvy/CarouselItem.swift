//
//  CarouselItem.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/7/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit
import MBProgressHUD

class CarouselItem: UIView {
    
    
    
    
    var loadingNotification: MBProgressHUD!
    
    var vc: FavoritesViewController!
    
    var index: Int!
    
    var content: Content!
    
    var recomendations = [Content]()
    
    @IBOutlet var showTitle: UILabel!
    
    @IBOutlet var showImage: UIImageView!
    
    
    func getRecommendations(){
        
        if recomendations.count < 0{
            vc.recomendations = recomendations
        }
        
        vc.socket.ws.send(content.guidebox_id!)
        loadingNotification = MBProgressHUD.showAdded(to: vc.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        
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

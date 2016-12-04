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
    
    var socket: SocketIOManager!
    
    var isActive: Bool! {
        willSet{
            if newValue == true {
                if socket != nil {
                    socket.ws.close()
                }
                openSocket()
            } else {
                self.socket.ws.close()
            }
        }
    }
    
    @IBOutlet var showTitle: UILabel!
    
    @IBOutlet var showImage: UIImageView!
    
    
    func getRecommendations(){
        
        if recomendations.count > 0{
            vc.recomendations = recomendations
        } else {
            
        
        
        socket.ws.send(content.guidebox_id!)
        loadingNotification = MBProgressHUD.showAdded(to: vc.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        }
    }
    
    override func willChangeValue(forKey key: String) {
        let x = "hello"
    }

    
    func openSocket(){
        self.recomendations = [Content]()
        //add closing logic
        socket = SocketIOManager(endpoint: "recomendations")
        
        
        socket.ws.event.message = { message in
            
            let data:Data = (message as! String).data(using: .utf8)!
            var error: NSError?
            
            
            let the_json =  Common.getReadableJsonDict(data: data)
            
            
            self.vc.recomendations.append(Content.parseDetail(dict: the_json as AnyObject))
            
            
            //            self.recomendationCollectionView.reloadData()
            
            MBProgressHUD.hideAllHUDs(for: self.vc.view, animated: true)
            
        }
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

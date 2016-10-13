//
//  DeepLinkCollectionViewCell.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/11/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import Foundation
import Dollar


class LinkViewCell: UICollectionViewCell {
        
        @IBOutlet weak var linkImageView: UIImageView!
        @IBOutlet weak var linkLabelview: UILabel!
        
        var image_name: String?
        
        
        var subscriptionIOSSource : IOSSubscriptionSource? {
                didSet{
                        linkLabelview.text = subscriptionIOSSource?.display_name
                        
                        let jsContext = Common.getJSContext()
                        
                        let test = jsContext.evaluateScript("_.snakeCase('Hello World')").toString()
                        
                        let value = jsContext.evaluateScript("_.snakeCase('\(subscriptionIOSSource?.display_name)')")
                        
                        if let x = value?.toString(){
                                image_name = x
                        }
                        if let y = image_name{
                                linkImageView.image = UIImage(named: y)
                                
                        }
                }
        }
        
        var purchaseIOSSource: IOSPurchaseSource? {
                didSet {
                        linkLabelview.text = purchaseIOSSource?.display_name
                }
        }
        
        
        func openDeepLink(){
                
                if let source = subscriptionIOSSource{
                        if Common.schemeAvailable(deepLink: source.link!){
                                Common.openDeepLink(link: source.link!)
                        } else {
                                
                                Common.openDeepLink(link: source.app_download_link!)
                                
                        }
                }
                
                
                if let source = purchaseIOSSource {
                        if Common.schemeAvailable(deepLink: source.link!){
                                Common.openDeepLink(link: source.link!)
                        } else {
                                
                                Common.openDeepLink(link: source.app_download_link!)
                                
                        }
                }
                
                
        }
        
}

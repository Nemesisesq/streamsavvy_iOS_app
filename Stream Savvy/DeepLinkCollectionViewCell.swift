//
//  DeepLinkCollectionViewCell.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/11/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import Foundation
import Dollar
import JavaScriptCore


class LinkViewCell: UICollectionViewCell {
        
        @IBOutlet weak var linkImageView: UIImageView!
        @IBOutlet weak var linkLabelview: UILabel!
        
        var image_name: String?
        var test: String?
        var jsValue: JSValue?
        var jsContext: JSContext?
        var display_name: String?
        
        
        var subscriptionIOSSource : IOSSubscriptionSource? {
                didSet{
                        linkLabelview.text = subscriptionIOSSource?.display_name
                        
                        jsContext = Common.getJSContext()
                        
                        test = jsContext?.evaluateScript("_.snakeCase('Hello World')").toString()
                        
                        if let res = subscriptionIOSSource?.display_name {
                                display_name = res
                        }
                        
                        if let res = jsContext?.evaluateScript("_.snakeCase('\(display_name!)')"){
                                jsValue = res
                        }
                        
                        if let res = jsValue{
                                image_name = res.toString()
                                linkImageView.image = UIImage(named: image_name!)
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

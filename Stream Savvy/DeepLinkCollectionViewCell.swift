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
import Appz


class LinkViewCell: UICollectionViewCell {
        
        @IBOutlet weak var linkImageView: UIImageView!
        @IBOutlet weak var linkLabelview: UILabel!
        
        var image_name: String?
        var test: String?
        var jsValue: JSValue?
        var jsContext: JSContext?
        var display_name: String?
        var isHeightCalculated = false
        
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
                                image_name = "marks_\(image_name!)"
                                linkImageView.image = UIImage(named: image_name!)
                                
                        }
                        
                        
                        if linkImageView.image != nil{
                                self.linkLabelview.isHidden = true
                        }
                        
                        
                }
                
        }
        
        var purchaseIOSSource: IOSPurchaseSource? {
                didSet {
                        linkLabelview.text = purchaseIOSSource?.display_name
                        
                        jsContext = Common.getJSContext()
                        
                        test = jsContext?.evaluateScript("_.snakeCase('Hello World')").toString()
                        
                        if let res = purchaseIOSSource?.display_name {
                                display_name = res
                        }
                        
                        if let res = jsContext?.evaluateScript("_.snakeCase('\(display_name!)')"){
                                jsValue = res
                        }
                        
                        if let res = jsValue{
                                image_name = res.toString()
                                image_name = "marks_\(image_name!)"
                                linkImageView.image = UIImage(named: image_name!)
                        }
                        
                        
                        if linkImageView.image != nil{
                                self.linkLabelview.isHidden = true
                        }
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
        
        
        override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
                
                let height: CGFloat = 30
                let ratio = linkImageView.image!.size.width/linkImageView.image!.size.height
                let finalWidth = ratio * height
                layoutAttributes.frame.size.height = height
                layoutAttributes.frame.size.width = finalWidth
                
                
                return layoutAttributes
        }
}

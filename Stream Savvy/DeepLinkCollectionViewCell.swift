//
//  DeepLinkCollectionViewCell.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/11/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import Foundation


class LinkViewCell: UICollectionViewCell {
        
        @IBOutlet weak var linkImageView: UIImageView!
        @IBOutlet weak var linkLabelview: UILabel!
        
        
        var subscriptionWebSource : SubscriptionWebSource? {
                didSet{
                        linkLabelview.text = subscriptionWebSource?.display_name
                }
        }
        
        
        func openDeepLink(){
                
                if let link =  subscriptionWebSource?.link{
                        Common.openDeepLink(link: link)
                }
        }
        
}

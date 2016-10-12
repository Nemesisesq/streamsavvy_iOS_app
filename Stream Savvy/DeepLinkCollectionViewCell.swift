git//
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
        
        
        var subscriptionIOSSource : IOSSubscriptionSource? {
                didSet{
                        linkLabelview.text = subscriptionIOSSource?.display_name
                }
        }
        
        
        func openDeepLink(){
                
                if let link =  subscriptionIOSSource?.link{
                        Common.openDeepLink(link: link)
                }
        }
        
}

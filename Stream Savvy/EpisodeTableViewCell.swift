//
//  EpisodeTableViewCell.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/17/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit
import UICollectionViewLeftAlignedLayout
import JavaScriptCore


class EpisodeTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


        var episode: Episode?
        
        var link = [String]() {
                didSet {
                        linkCollectionView.reloadData()
                }
        }
        
        
        
        var jsContext: JSContext = Common.getJSContext()
        
        @IBOutlet weak var seEp: UILabel!
        
        @IBOutlet var epTitle: UILabel!
        
        @IBOutlet var episodeImage: UIImageView!
        
        @IBOutlet var linkCollectionView: UICollectionView!
        
        
        
        
}

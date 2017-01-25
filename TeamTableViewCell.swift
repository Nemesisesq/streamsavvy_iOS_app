//
//  TeamTableViewCell.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 1/2/17.
//  Copyright © 2017 StreamSavvy. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    @IBOutlet var teamName: UILabel!
    @IBOutlet var img: UIImageView!
    var fav: Bool = false {
        didSet{
            
            if fav {
                self.accessoryType = .checkmark
            } else {
                self.accessoryType = .none
            }
        }
    }
    
    var team :Team! {
        didSet {
            teamName.text = team.name
        }
    }
    
    override func prepareForReuse() {
        fav = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

//
//  SetupTableViewCell.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 12/28/16.
//  Copyright © 2016 StreamSavvy. All rights reserved.
//

import UIKit

class SetupTableViewCell: UITableViewCell {
    
    var fav : Bool! = false
    
    var sport: Sport! {
        didSet{
            self.sportName.text = sport.sportsName
        }
    }
    
    @IBOutlet var sportName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

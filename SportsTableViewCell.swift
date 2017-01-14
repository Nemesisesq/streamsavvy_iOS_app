//
//  SetupTableViewCell.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 12/28/16.
//  Copyright © 2016 StreamSavvy. All rights reserved.
//

import UIKit

class SetupTableViewCell: UITableViewCell {
    
    var fav : Bool = false {
        didSet{
            
            if fav {
                self.accessoryType = .checkmark
            } else {
                self.accessoryType = .none
            }
        }
    }

    
    var sport: Sport! {
        didSet{
            self.sportName.text = sport.sportsName
        }
    }
    
    @IBOutlet var sportName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .black
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

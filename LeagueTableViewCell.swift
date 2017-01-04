//
//  LeagueTableViewCell.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 1/3/17.
//  Copyright © 2017 StreamSavvy. All rights reserved.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {
    
    var org: Organization! {
        didSet{
            label?.text = org.organization
            img?.sd_setImage(with: URL.init(string: org.imageURL))
        }
    }
    
    @IBOutlet var img: UIImageView?
    @IBOutlet var label: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

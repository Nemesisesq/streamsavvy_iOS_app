//
//  SeasonCollectionViewCell.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/11/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import Foundation

class SeasonViewCell: UICollectionViewCell {
        
        @IBOutlet var seasonLabel: UILabel!
        
        
        override var isSelected: Bool {
                willSet {
                        
                }
                
                didSet {
                        
                        if self.isSelected {
                                let v = UIView()
                                v.backgroundColor = .white
                                self.selectedBackgroundView = v
//                                self.seasonLabel?.textColor = Constants.streamSavvyRed()
                                self.seasonLabel.highlightedTextColor = Constants.streamSavvyRed()

                        }
                        
                }
                
        }
        
        
}

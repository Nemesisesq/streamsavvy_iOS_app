//
//  EpisodeCollectionViewCell.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/11/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import Foundation


class EpisodeViewCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
        
        var episode: Episode?
        
        var link = [String]() {
                didSet {
                        linkCollectionView.reloadData()
                }
        }
        
        @IBOutlet weak var seEp: UILabel!
        
        @IBOutlet var epTitle: UILabel!
        
        @IBOutlet var linkCollectionView: UICollectionView!
        
        @IBOutlet var image: UIImageView!
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
                return 2
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                
                
                if section == 0 {
                        if let sws = episode?.subscription_ios_sources {
                                return sws.count
                        }
                        
                }
                
                if section == 1 {
                        
                        if let pws = episode?.purchase_ios_sources {
                                return pws.count
                        }
                        
                }
                
                
                return 0
                
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LinkCell", for: indexPath) as! LinkViewCell
                
                if (indexPath.section == 0) {
                        if let sws = episode?.subscription_ios_sources {
                                cell.subscriptionIOSSource = sws[indexPath.row]
                        }
                }
                
                if (indexPath.section == 1) {
                        if let pws = episode?.purchase_ios_sources {
                                cell.purchaseIOSSource = pws[indexPath.row]
                        }
                }

                
                
                return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                let cell = collectionView.cellForItem(at: indexPath) as! LinkViewCell
                cell.openDeepLink()
                
                
        }
        
}

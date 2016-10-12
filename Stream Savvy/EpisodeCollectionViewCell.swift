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
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
<<<<<<< HEAD
                
<<<<<<< HEAD
                
                if section == 0 {
                        if let sws = episode?.subscription_ios_sources {
                                return sws.count
                        }
                        
                }
                
                if section == 1 {
                        
                        if let pws = episode?.purchase_ios_sources {
                                return pws.count
                        }
                        
=======
		print("###")
                if let sws = episode?.subscription_ios_sources {
                        return sws.count
>>>>>>> d0d1039d6fd261150e9166a4a5932fa9d2738e43
=======
                if let sws = episode?.subscription_ios_sources {
                        return sws.count
>>>>>>> parent of 61be325... completed wiring for deep links
                }
                
                return 0
                
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LinkCell", for: indexPath) as! LinkViewCell
                if let sws = episode?.subscription_ios_sources {
                       cell.subscriptionIOSSource = sws[indexPath.row]
                }
                
                
                return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                let cell = collectionView.cellForItem(at: indexPath) as! LinkViewCell
                cell.openDeepLink()
                
                
        }
        
}

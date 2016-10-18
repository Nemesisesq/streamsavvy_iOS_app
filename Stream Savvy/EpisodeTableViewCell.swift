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


class EpisodeTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
        var jsContext: JSContext = Common.getJSContext()
        
        @IBOutlet weak var seEp: UILabel!
        
        @IBOutlet var epTitle: UILabel!
        
        @IBOutlet var episodeImage: UIImageView!
        
        @IBOutlet var linkCollectionView: UICollectionView!
        
        var episode: Episode?
        
        var link = [String]() {
                didSet {
                        linkCollectionView.reloadData()
                }
        }
        
        override func awakeFromNib() {
                super.awakeFromNib()
                // Initialization code
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
                super.setSelected(selected, animated: animated)
                
                // Configure the view for the selected state
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
                return CGSize.init(width: 200, height: 40)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                if indexPath.section == 0 {
                        if let source = episode?.subscription_ios_sources?[indexPath.row] {
                                
                                
                                if let res = jsContext.evaluateScript("_.snakeCase('\(source.display_name!)')"){
                                        let jsValue = res
                                        
                                        if let res = jsValue.toString() {
                                                var image_name = res
                                                image_name = "marks_\(image_name)"
                                                let img = UIImage(named: image_name)
                                                
                                                let height: CGFloat = 30
                                                let ratio = (img?.size.width)!/(img?.size.height)!
                                                let finalWidth = ratio * height
                                                
                                                return CGSize(width: finalWidth, height: height)
                                        }
                                }
                                
                        }
                } else {
                        if let source = episode?.purchase_ios_sources?[indexPath.row]{
                                
                                if let res = jsContext.evaluateScript("_.snakeCase('\(source.display_name!)')"){
                                        let jsValue = res
                                        
                                        
                                        if let rez = jsValue.toString() {
                                                var image_name = rez
                                                image_name = "marks_\(image_name)"
                                                let img = UIImage(named: image_name)
                                                
                                                let height: CGFloat = 30
                                                let ratio = (img?.size.width)!/(img?.size.height)!
                                                let finalWidth = ratio * height
                                                
                                                return CGSize(width: finalWidth, height: height)
                                        }
                                        
                                }
                                
                        }
                        
                }
                return CGSize(width: 0, height: 0)
        }
        
        
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
        
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "deep_links", for: indexPath) as! LinkCellCollectionReusableView
                if indexPath.section == 0 {
                        view.viewingWindow.text = "Subscription"
                } else {
                        view.viewingWindow.text = "Buy This Episode"
                }
                
                return view
                
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                let cell = collectionView.cellForItem(at: indexPath) as! LinkViewCell
                cell.openDeepLink()
                
                
        }
}

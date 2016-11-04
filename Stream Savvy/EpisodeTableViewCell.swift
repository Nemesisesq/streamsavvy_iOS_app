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
import Alamofire


class EpisodeTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var jsContext: JSContext = Common.getJSContext()
    
    var purchOffset: Int! = 0
    
    @IBOutlet weak var seEp: UILabel!
    
    @IBOutlet var epTitle: UILabel!
    
    @IBOutlet var episodeImage: UIImageView!
    
    @IBOutlet var linkCollectionView: UICollectionView!
    
    @IBOutlet var linkCollectionViewFlowLayout: LinkCollectionViewFlowLayout!
    var episode: Episode?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        linkCollectionViewFlowLayout.estimatedItemSize = CGSize(width:30, height:30)
        
        Alamofire.request("https://edr-go-staging.herokuapp.com/fff", method:.get)
            .responseJSON { r in
                
                switch r.result {
                case .success:
                    self.purchOffset = 1
                case .failure(let _):
                    self.purchOffset = 0
                }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            
            linkCollectionView.reloadData()
            linkCollectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        
        switch section {
        case 0:
            if episode?.free_ios_sources == nil || episode?.free_ios_sources?.count == 0 {
                return CGSize.init(width: 0, height: 0)
            }
            
        case 1:
            if let sub = episode?.subscription_ios_sources , sub.count == 0 && section == 1{
                return CGSize.init(width: 0, height: 0)
            }
        case 2:
            if let purch = episode?.purchase_ios_sources, purch.count == 0 && section == 2 {
                return CGSize.init(width: 0, height: 0)
            }
        default:
            return CGSize.init(width: 200, height: 40)
        }
        
        return CGSize.init(width: 200, height: 40)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            if let fis = episode?.free_ios_sources {
                return fis.count
            }
        }
        
        if section == 1 {
            if let sws = episode?.subscription_ios_sources {
                return sws.count
            }
        }
        
        if section == 2 {
            if let pws = episode?.purchase_ios_sources {
                return pws.count - purchOffset
            }
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LinkCell", for: indexPath) as! LinkViewCell
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let x = cell as? LinkViewCell {
            
            switch indexPath.section {
            case  0:
                if let fis = episode?.free_ios_sources {
                    x.freeIOSSource = fis[indexPath.row]
                }
            case 1:
                if let sws = episode?.subscription_ios_sources {
                    x.subscriptionIOSSource = sws[indexPath.row]
                }
            case 2:
                if let pws = episode?.purchase_ios_sources {
                    x.purchaseIOSSource = pws[indexPath.row]
                }
                
            default:
                print("Hello World")
            }
        }
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "deep_links", for: indexPath) as! LinkCellCollectionReusableView
        
        if indexPath.section == 0 {
            view.viewingWindow.text = "Free"
        } else if indexPath.section == 1 {
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

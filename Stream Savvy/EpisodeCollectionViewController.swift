//
//  EpisodeCollectionViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 9/27/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit
import PromiseKit
import Dollar

struct Season {
    var number : Int
    var episodes  : [Episode]
    
}
class SeasonViewCell: UICollectionViewCell {
    
    @IBOutlet var seasonLabel: UILabel!
}
class EpisodeViewCell: UICollectionViewCell {
    
    @IBOutlet weak var seEp: UILabel!
    
    @IBOutlet var epTitle: UILabel!
    
}

class EpisodeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var seasonCollectionView: UICollectionView!
    @IBOutlet weak var mediaTitleLabel: UILabel!
    @IBOutlet var episodeCollectionView: UICollectionView!
    var currentIndex: Int!
    var episodes: [Episode]!
    var content: Content!
    var seasons: [Int:[Episode]]!
    
    
    
    override func awakeFromNib() {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
	print("4")
        self.mediaTitleLabel.text = self.content.title
	print("3")
	print("\(self.content.title!)")
	print("3")
	print("\(self.content.guidebox_id!)")
	print("2.5")
        Episode.getEpisodeList(guidebox_id: "\(content.guidebox_id!)")
            .then{ epiList -> Void in
                print("0")
                self.episodes = epiList
                print("00")
                self.seasons = $.groupBy((self.episodes as? Array<Episode>)!, callback: { $0.seasonNumber! })
                print("000")
                
                self.seasonCollectionView.reloadData()
		print("0000")
                self.episodeCollectionView.reloadData()
		print("00000")
            }.catch { error in
                print(error)
                
        }
	print("2")
        
        currentIndex = 0
        print("1")
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        //        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if self.seasons != nil && !self.seasons.isEmpty {
            if (collectionView.restorationIdentifier == "seasons" ){
                return self.seasons.count
            } else {
                return self.seasons[currentIndex + 1]!.count
            }
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        // Configure the cell
        if (collectionView.restorationIdentifier == "seasons"){
            var cell: SeasonViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Season", for: indexPath) as! SeasonViewCell
            
            cell.seasonLabel?.text = "Season \(indexPath.row)"
            
            return cell
            
        } else {
            var cell: EpisodeViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Episode", for: indexPath) as! EpisodeViewCell
            
            let episode = self.seasons[currentIndex + 1]?[indexPath.row]
            
            cell.seEp?.text = "Season \(currentIndex + 1) Episode \(episode!.episodeNumber!)"
            
            cell.epTitle?.text = "\(episode!.title!)"
            
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        episodeCollectionView?.reloadData()
    }
    
    // MARK: UICollectionViewDelegate
    
    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}

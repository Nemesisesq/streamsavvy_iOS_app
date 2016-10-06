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
        var seasons: [String:[Episode]]!
        
        
        
        override func awakeFromNib() {
        }
        
        
        override func viewDidLoad() {
                super.viewDidLoad()
                self.mediaTitleLabel.text = self.content.title
                        Episode.getEpisodeList(guidebox_id: "\(content.guidebox_id!)")
//                Episode.getEpisodeList(guidebox_id: "2098")
                        .then{ epiList -> Void in
                                self.episodes = epiList
                                self.seasons = $.groupBy((self.episodes as Array<Episode>), callback: { String($0.seasonNumber!) })
                                self.seasonCollectionView.reloadData()
                                self.episodeCollectionView.reloadData()
                        }.catch { error in
                                print(error)
                                
                }
                currentIndex = 0
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
		print("numberodsexonsinitem")
                if self.seasons != nil && !self.seasons.isEmpty {
			print("numberodsexonsinitem un")
                        if (collectionView.restorationIdentifier == "seasons" ){
				print("numberodsexonsinitem 1 dun")
				return self.seasons.count
                        } else {
                                let key: String = String(currentIndex + 1)
                                let epis = self.seasons?[key]
                                return (epis?.count)!
                        }
                }
                print("numberodsexonsinitem 3 dun")
                return 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
                // Configure the cell
                if (collectionView.restorationIdentifier == "seasons"){
                        let cell: SeasonViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Season", for: indexPath) as! SeasonViewCell
                        
                        cell.seasonLabel?.text = "\(indexPath.row + 1)"
			
			return cell
                        
                } else {
                        let cell: EpisodeViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Episode", for: indexPath) as! EpisodeViewCell
                        
                        let episode = self.seasons[String(currentIndex + 1)]?[indexPath.row]
                        
                        cell.seEp?.text = "Episode \(episode!.episodeNumber!)"
                        
                        cell.epTitle?.text = "\(episode!.title!)"
			
			let backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width:cell.frame.size.width, height: cell.frame.size.height));
			backgroundImageView.contentMode = UIViewContentMode.scaleAspectFill
			backgroundImageView.clipsToBounds = true
			SDWebModel.loadImage(for: backgroundImageView, withRemoteURL: episode?.thumbnail608X342)
			let overLayImageView = UIImageView(frame: CGRect(x: 0, y: 0, width:cell.frame.size.width, height: cell.frame.size.height));
			overLayImageView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
			
			cell.addSubview(backgroundImageView)
			cell.addSubview(overLayImageView)
			cell.sendSubview(toBack: overLayImageView)
			cell.sendSubview(toBack: backgroundImageView)
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

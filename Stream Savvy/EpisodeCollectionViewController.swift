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



class EpisodeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
        
        @IBOutlet var episodeTableView: UITableView!
        
        @IBOutlet var seasonCollectionView: UICollectionView!
        @IBOutlet weak var mediaTitleLabel: UILabel!
        //        @IBOutlet var episodeCollectionView: UICollectionView!
        var currentIndex: Int?
        var selectedIndex: Int?
        var episodes: [Episode]!
        var content: Content!
        var seasons: [Int:[Episode]]!
        
        var seasonKeys: [Int]?
        
        var key: Int!
        
        var season: [Episode]!
        
        var seasonKey: Int!
        var episode : Episode!
        
        
        override func viewDidLoad() {
                super.viewDidLoad()
                self.mediaTitleLabel.text = self.content.title
                Episode.getEpisodeList(guidebox_id: "\(content.guidebox_id!)")
                        //                Episode.getEpisodeList(guidebox_id: "2098")
                        .then{ epiList -> Void in
                                self.episodes = epiList
                                self.seasons = $.groupBy((self.episodes as Array<Episode>), callback: { $0.seasonNumber! })
                                self.seasonKeys = $.keys(self.seasons).sorted()
                                self.seasonCollectionView.reloadData()
                                self.episodeTableView.reloadData()
                        }.catch { error in
                                print(error)
                                
                }
                //                currentIndex = 0
                // Uncomment the following line to preserve selection between presentations
                // self.clearsSelectionOnViewWillAppear = false
                
                // Register cell classes
                //        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
                
                // Do any additional setup after loading the view.
                
        }
        
        override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(true)
                
                self.navigationController?.tabBarController?.tabBar.isHidden = true
        }
        
        override func viewWillDisappear(_ animated: Bool) {
                super.viewWillDisappear(true)
                self.navigationController?.tabBarController?.tabBar.isHidden = false
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
                        
                        return self.seasons.count
                        
                }
                
                return 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
                // Configure the cell
                
                let cell: SeasonViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Season", for: indexPath) as! SeasonViewCell
                
                
                if  let k = seasonKeys?[indexPath.row] {
                        cell.seasonLabel?.text = String(describing: k)

                }
                
                if currentIndex != nil{
                let path = IndexPath.init(item: currentIndex!, section: 0)
//                collectionView.deselectItem(at: path, animated: true)
                }

                if $.equal(indexPath.row, currentIndex) {
                        
                        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top )
                         cell.isSelected = true
                        
                }
                
                
                if currentIndex == nil{
                        
                        currentIndex = 0
                        if $.equal(indexPath.row, currentIndex){
                                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top )
                                cell.isSelected = true
                        }
                        
                        
                        collectionView.reloadData()
                        episodeTableView.reloadData()
                        
                }
                return cell
                
                
        }
        
        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
                if (collectionView.restorationIdentifier != "seasons"){
                        if let cell = cell as? EpisodeViewCell {
                                cell.linkCollectionView.reloadData()
                        }
                }
        }
        
        
        
        // MARK: UICollectionViewDelegate
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
                
                
                currentIndex = indexPath.row
                selectedIndex = nil
                episodeTableView.reloadData()
                
        }
        
        
        // Uncomment this method to specify if the specified item should be highlighted during tracking
        
        
        
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

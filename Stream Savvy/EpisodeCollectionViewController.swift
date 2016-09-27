//
//  EpisodeCollectionViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 9/27/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit

struct Season {
    var number : Int
    var episodes  : [Int]

}

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myLabel: UILabel!
}

class EpisodeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var currentIndex = 0
    
    
    
    let episodes = [ Season(number:1, episodes: [1, 2, 3, 4, 5, 6, 7, 8]),
                     Season(number:2, episodes: [1, 2, 3, 4, 5, 6, 7, 8]),
                     Season(number:3, episodes: [1, 2, 3, 4, 5, 6, 7, 8]),
                     Season(number:4, episodes: [1, 2, 3, 4]),
                        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        if (collectionView.restorationIdentifier == "seasons"){
            return self.episodes.count
        } else {
            let season = self.episodes[currentIndex]
            return season.episodes.count
        }

//        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Episode", for: indexPath)
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Season", for: indexPath)
        
        // Configure the cell
        
        if (true){
            let season = self.episodes[currentIndex]
//            cell.myLabel.text = "Season \(season.number)"
        }
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
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

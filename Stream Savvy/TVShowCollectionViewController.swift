//
//  SecondSetupViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 12/28/16.
//  Copyright © 2016 StreamSavvy. All rights reserved.
//

import UIKit
import Dollar
import Crashlytics

class SecondSetupViewController: PopularShowObjectiveCViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    var favorites: Favorites!
    override var popularShows: [Any]!{
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    var setupFaves: [PopularShow]!
    
    
    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFaves = [PopularShow]()
        
        collectionView?.infiniteScrollIndicatorStyle = .white
        
        collectionView.infiniteScrollTriggerOffset = 500
        
        collectionView?.addInfiniteScroll { [weak self] (scrollView) -> Void in
            
            _ = Content.getNextPage(url: (self?.nextPage)!)
                .then { the_json -> Void in
                    
                    self?.nextPage = the_json["next"] as? String
                    self?.previous = the_json["previous"] as? String
                    
                    var indexPaths = [IndexPath]()
                    let index = self?.popularShows.count
                    var s = [PopularShow]()
                    
                    for show in the_json["results"] as! [[AnyHashable:Any]] {
                        let count = index!
                        let indexPath = IndexPath(item: count, section: 0)
                        
                        indexPaths.append(indexPath)
                        s.append(PopularShow.init(attributes: show))
                    }
                    
                    self?.collectionView.performBatchUpdates({ () -> Void in
                        self?.popularShows = $.merge((self?.popularShows)!, s)
                        self?.collectionView.insertItems(at: indexPaths)
                    }, completion: { (finished) -> Void in
                        self?.collectionView.finishInfiniteScroll()
                    })
            }
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let x = popularShows?.count {
            return x
            
        }
        
        return 0
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TVSetUpCollectionViewCell
        setupFaves.append(popularShows[indexPath.row] as! PopularShow)
        
        let popshow = popularShows[indexPath.row] as! PopularShow
        let show = Content.init(withPopularShow: popshow)
        
        let mutation = GraphQLAPI.toggleShowToFavorites(show: show, favorite: !cell.fav).create()
        
        _ = GraphQLAPI.fetchGraphQLQuery(q: mutation)
            .then { the_json -> Void in
                
                if let t = the_json["data"] as? [String: [String: Any]]{
                    
                    let state = t["toggleShow"]?["status"] as! Bool
                    cell.fav = state
                    cell.isHighlighted = state

                }
                
                        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TVSetUpCollectionViewCell
        
        return cell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let show = popularShows[indexPath.row] as! PopularShow
        let cell = cell as! TVSetUpCollectionViewCell
        cell.imgView.sd_setImage(with: URL(string : show.image_link ))

        cell.popularShow = show
 
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

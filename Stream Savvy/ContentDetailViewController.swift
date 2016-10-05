//
//  ContentDetailViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 9/25/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit
import Dollar

class ContentDetailViewController: UIViewController  {
        
        var hello = "Detailed World"
        
        var content: Content!
        
        var show: PopularShow!
        
        var media: Media!
        
        var isDisplayingPopularShows: Bool!
        
        var sources: [MediaSource]!
        
        
        @IBOutlet var genres: UILabel!
        @IBOutlet var showTitle: UILabel!
        @IBOutlet weak var backgroundImageView: UIImageView!
        @IBOutlet weak var addFavoriteButton: UIButton!
        
        @IBAction func addContentToFavorites(_ sender: UIButton) {
                Favorites.addContentToFavorites(content: content)
                        .then { _ -> Void in
                                //                self.performSegue(withIdentifier: "ContentAdded", sender: sender)
                                print("Successsss")
                                
                                //                let fvc = self.storyboard?.instantiateViewController(withIdentifier: "FavoritesViewController")
                                //                self.present(fvc!, animated: true, completion: nil)
                                self.navigationController?.popViewController(animated: true)
                }
        }
        
        
        override func viewDidLoad() {
                super.viewDidLoad()
                
                if content == nil {
                        content = Content(withPopularShow: show)
                }
                
                
                //        self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.tabBarController?.tabBar.isHidden = true
                
                if content == nil {
                        showTitle.text = show.title
                } else {
                        showTitle.text = content.title
                }
                SDWebModel.loadImage(for: backgroundImageView, withRemoteURL: show.image_link)
                
                genres.text = $.join(show.genres as! [String], separator: " | ")
                
                // Do any additional setup after loading the view.
        }
        
        override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
        }
        
        
        
        // MARK: - Navigation
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                // Get the new view controller using segue.destinationViewController.
                // Pass the selected object to the new view controller.
                
                let target = segue.destination as! EpisodeCollectionViewController
                
                
                target.content = content
                
                
                
                
        }
        
        override func viewDidDisappear(_ animated: Bool) {
                super.viewDidDisappear(animated)
                
                self.navigationController?.tabBarController?.tabBar.isHidden = true
        }
        
        
}

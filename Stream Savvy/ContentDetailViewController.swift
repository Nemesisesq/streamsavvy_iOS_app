//
//  ContentDetailViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 9/25/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit
import Dollar

class ContentDetailViewController:  Auth0ViewController  {
    
    var hello = "Detailed World"
    
    var content: Content!
    
    var show: PopularShow!
    
    var media: Media!
    
    var isDisplayingPopularShows: Bool!
    
    var sources: [MediaSource]!
    
    var favorites: Favorites!
    
    
    @IBOutlet weak var showDetailsLabel: UILabel!
    @IBOutlet var genres: UILabel!
    @IBOutlet var showTitle: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var addFavoriteButton: UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBAction func addContentToFavorites(_ sender: UIButton) {
        
        let titles  = favorites.contentList.map { $0.title } as [String]
        
        if $.contains(titles, value: content.title){
            
            Constants.showAlert("Great News!!!", withMessage: "You already added \(content.title!)")
        }
            
        else {
            
            favorites.addContentToFavorites(content: content)
                .then { _ -> Void in
                    
                    if let navigationController = self.navigationController {
                        navigationController.popViewController(animated: true)
                    }
                    
                }.catch{ err in
                    print(err)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth0.calledBySubclass = true
        if favorites == nil  {
            favorites = Favorites()
        }
        if Auth0.loggedIn {
            _ = favorites.fetchFavorites().then{ result -> Void in
                
                self.favorites.contentList = self.favorites.contentList.reversed()
                
                
                let titles  = self.favorites.contentList.map { $0.title } as [String]
                
                if $.contains(titles, value: self.content.title){
                    
                    self.addFavoriteButton.isEnabled = false
                    self.addFavoriteButton.setTitle("Already Added", for: .normal)
                }
            }
            
            
            if content == nil {
                content = Content(withPopularShow: show)
            }
            
            //MARK - Here we hid the tool bar and make the navigation tool bar transparent
            
            //                self.navigationController?.navigationBar.barTintColor = nil
            
            
            if content == nil {
                showTitle.text = show.title
            } else {
                showTitle.text = content.title
                if media != nil {
                    showDetailsLabel.text = media.show_description
                }else{
                    showDetailsLabel.text = ""
                }
            }
            if show != nil {
                SDWebModel.loadImage(for: backgroundImageView, withRemoteURL: show.image_link)
                genres.text = $.join(show.genres as! [String], separator: " | ")
                if show.duration > 0 {
                    durationLabel.text = "\(show.duration) min"
                }
            }
            // Do any additional setup after loading the view.
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.tabBarController?.tabBar.isHidden = true
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
    
    //MARK - ReShow tool bar here we are tryingt o reshow the tool bar after exiting the view.
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //                if let tabBarController = self.navigationController?.tabBarController {
        //                        tabBarController.tabBar.isHidden = false
        //                }
        
        self.navigationController?.tabBarController?.tabBar.isHidden = false
        
    }
    
    
    
    //        override func viewDidDisappear(_ animated: Bool) {
    //                super.viewDidDisappear(animated)
    //
    //                if let tabBarController = self.navigationController?.tabBarController {
    //                        tabBarController.tabBar.isHidden = false
    //                }
    //
    //                self.navigationController?.tabBarController?.tabBar.isHidden = false
    //        }
    
    
}

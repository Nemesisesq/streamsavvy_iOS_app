//
//  ViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/4/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit
import Dollar

class AppCell: UICollectionViewCell {
    
    @IBOutlet var image: UIImageView!
    
}


class LiveDetailsViewController:  Auth0ViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var appCollectionView: UICollectionView!
    @IBOutlet var channelImage: UIImageView!
    
    var channel: Channel!
    
    var media: Media!
    
    var sources: [MediaSource]!
    
    @IBOutlet var backgroundImage: UIImageView!
    
    @IBOutlet var backgroundMask: UIImageView!
    
    @IBOutlet var showTitle: UILabel!
    
    
    @IBOutlet weak var showSubtitleLabel: UITextView!
    
    @IBOutlet var showProgress: UIProgressView!
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var genres: UILabel!
    //
    @IBOutlet var sportsUIView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth0.calledBySubclass = true
        
        print("THERE")
        self.sources = [MediaSource]()
        // MARK - This is where we make the call to get the streaming services for the channel
        
        channel.getDetailsWith(containerView, success: {task, JSON in
            
            //                        print("supercal")
            let the_json = JSON as! NSDictionary
            let sourceDict = the_json.object(forKey: "streamingServices") as! [[String:Any]]
            
            sourceDict.forEach(){src in
                
                let mSrc: MediaSource = MediaSource.init(attributes: src)
                self.sources.append(mSrc)
                
            }
            
            self.appCollectionView.reloadData()
            self.appCollectionView.collectionViewLayout.invalidateLayout()
            
            
            
        })
        showTitle.text			= media.title
        showSubtitleLabel.text	= media.show_description
        //                showSubtitleLabel.text	= "Channel \(channel.channel_number!)"
        sportsUIView.isHidden	= true
        
        
        //                if media.show_description != nil {
        //                        if media.episodeTitle == nil {
        //                                showSubtitleLabel.text = media.show_description
        //                                showSubtitleLabel.sizeToFit()
        //                        } else{
        //                                showSubtitleLabel.text = media.episodeTitle
        //                        }
        //                }
        SDWebModel.loadImage(for: channelImage, withRemoteURL: channel.image_link)
        
        genres.text = $.join(media.genres as! [String], separator: " | ")
        
        
        
        //
        
        
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
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    //MARK: - Progress View Updated TODO
    
    //MARK: - Collection View Delegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.sources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "app_icons", for: indexPath) as! AppCell
        
        //this needs to be hooked up
        
        let source = sources[indexPath.row]
        cell.image.image = UIImage(named:"\(source.source!)")
        cell.backgroundColor = Common.getRandomColor()
        
        return cell
    }
    
    //MARK: - Collection View Data Source
    
    let application = UIApplication.shared
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath) clicked")
        
        let source = sources[indexPath.row]
        
        let link = getDeepLink(deepLinks: source.deep_links as! [String])
        
        if link != "" {
            application.openURL(URL.init(string: link)!)
            
        } else {
            
            application.openURL(URL.init(string: source.app_store_link)!)
        }
        
        
        
    }
    
    func getDeepLink(deepLinks: [String]) -> String {
        for i in deepLinks {
            if schemeAvailable(deepLink: i){
                return i
            }
        }
        
        return ""
    }
    
    func schemeAvailable(deepLink: String) -> Bool {
        return application.canOpenURL(URL.init(string: deepLink)!)
    }
    
    
    
    
    
    
    
    
}

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


class LiveDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
        @IBOutlet var channelImage: UIImageView!
        
	var channel: Channel!
    
	var media: Media!
    
	@IBOutlet var backgroundImage: UIImageView!
    
	@IBOutlet var backgroundMask: UIImageView!
    
	@IBOutlet var showTitle: UILabel!
    
	@IBOutlet weak var showSubtitleLabel: UILabel!
	
	@IBOutlet var showProgress: UIProgressView!
    
	@IBOutlet var containerView: UIView!
    
	@IBOutlet var genres: UILabel!
    //
	@IBOutlet var sportsUIView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        channel.getDetailsWith(containerView, success: { JSON in
            
            print(JSON)
        })
        showTitle.text			= media.title
	showSubtitleLabel.text	= "Channel \(channel.channel_number!)"
        sportsUIView.isHidden	= true
	showProgress.isHidden	= true
//        
//        if media.show_description != nil {
//            if media.episodeTitle == nil {
//                episodeTitle.text = media.show_description
//                episodeTitle.sizeToFit()
//            } else{
//                episodeTitle.text = media.episodeTitle
//            }
//        }
        SDWebModel.loadImage(for: channelImage, withRemoteURL: channel.image_link)
        
        genres.text = $.join(media.genres as! [String], separator: " | ")
        
        
        
        //
        
        
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
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "app_icons", for: indexPath) as! AppCell
        
//        cell.image
        
        return cell
    }
    
    //MARK: - Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath) clicked")
        
    }
    
    
    
    
    
    
    
    
    
}

//
//  ViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/4/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit

class GenreCell: UICollectionViewCell {

    @IBOutlet var genreLabel: UILabel!
}


class LiveDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var channel: Channel!
    
    var media: Media!

    @IBOutlet var backgroundImage: UIImageView!

    @IBOutlet var backgroundMask: UIImageView!
    
    @IBOutlet var showTitle: UILabel!
    
    @IBOutlet var episodeTitle: UITextView!
    
    @IBOutlet var showProgress: UIProgressView!
    
    @IBOutlet var containerView: UIView!
    
    //
    @IBOutlet var sportsUIView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        channel.getDetailsWith(containerView, success: { JSON in
            
           print(JSON)
        })
        
        showTitle.text = media.title
        
        sportsUIView.isHidden = true
        
        
        if media.episodeTitle == nil {
            episodeTitle.text = media.show_description
            episodeTitle.sizeToFit()
        } else {
        episodeTitle.text = media.episodeTitle
        }
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
        
        if collectionView.restorationIdentifier == "GenreCollectionView" {
            return media.genres.count
        } else {
            
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genre", for: indexPath) as! GenreCell
        
        let genreArray = media.genres as! [String]
        
        cell.genreLabel.text = genreArray[indexPath.row]
        cell.genreLabel.sizeToFit()
        
        return cell
    }
    
    //MARK: - Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath) clicked")
        
    }

    
   
    
    
   



}

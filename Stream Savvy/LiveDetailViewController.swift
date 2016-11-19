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
    
    var service: MatchedLiveStreamingSourceSerivce!
    var presenter: LiveDetailsViewController!
    var showName: String!
    var versions: String!
    
    func prepareForDeepLink(service: MatchedLiveStreamingSourceSerivce){
        
        
        switch service.service {
        case "sling_blue":
            versions = "Blue, Blue+Orange"
        case "sling_orange":
            versions = "Orange, Blue+Orange"
        case "ps_vue_access":
            versions = "Playstation Vue Access"
        case "ps_vue_core":
            versions = "Playstation Vue Core"
        case "ps_vue_elite":
            versions = "Playstation Vue Elite"
        case "ps_vue_ultra":
            versions = "Playstation Vue Ultra"
        default:
            versions = service.app
        }
        
        
        var message = service.template.template.replacingOccurrences(of: "{service.template.versions}", with: versions)
        message = message.replacingOccurrences(of: "{showName}", with: showName )
        message = message.replacingOccurrences(of: "{service.price.unit_cost}", with: service.price.unitCost)
        message = message.replacingOccurrences(of: "\\n", with: "\n")
        
        
        let alert = UIAlertController(title: "One More Thing!!", message: "", preferredStyle: .actionSheet)
        let attributedString = NSAttributedString(string: message, attributes: [
            NSForegroundColorAttributeName : UIColor.black
            ])
        
        
        alert.setValue(attributedString, forKey: "attributedTitle")
        
        //        alert.view.
        alert.addAction(UIAlertAction(title: "Watch Now", style: .default, handler: { _ in
            
            
            if let url = URL.init(string: service.links.deeplink){
                if application.canOpenURL(url) {
                    application.openURL(url)
                } else {
                    if let appStoreUrl = URL.init(string: service.links.app_store) {
                        application.openURL(appStoreUrl)
                    }
                }
                
            } else {
                if let appStoreUrl = URL.init(string: service.links.app_store) {
                    application.openURL(appStoreUrl)
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Learn More", style: .default, handler: { _ in
            application.openURL(URL(string: service.links.signup)!)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        presenter.present(alert, animated: true, completion: nil)
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


class LiveDetailsViewController:  Auth0ViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var appCollectionView: UICollectionView!
    @IBOutlet var channelImage: UIImageView!
    
    var channel: Channel!
    
    var media: Media!
    
    var sources: [MediaSource]!
    
    var timer: Timer!
    
    var matchedLiveStreamingServices : [MatchedLiveStreamingSourceSerivce]!
    
    var uniqueMatchedLiveStreamingServices: [MatchedLiveStreamingSourceSerivce]!
    
    @IBOutlet var backgroundImage: UIImageView!
    
    @IBOutlet var backgroundMask: UIImageView!
    
    @IBOutlet var showTitle: UILabel!
    
    
    @IBOutlet weak var showSubtitleLabel: UITextView!
    
    @IBOutlet var showProgress: UIProgressView!
    
    @IBOutlet var elapsedTime: UILabel!
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var genres: UILabel!
    //
    @IBOutlet var sportsUIView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth0.calledBySubclass = true
        
        print("THERE")
        self.sources = [MediaSource]()
        self.matchedLiveStreamingServices = [MatchedLiveStreamingSourceSerivce]()
        self.uniqueMatchedLiveStreamingServices = [MatchedLiveStreamingSourceSerivce]()
        // MARK - This is where we make the call to get the streaming services for the channel
        
        channel.getDetailsWith(containerView, success: {task, JSON in
            
            //                        print("supercal")
            let the_json = JSON as! NSDictionary
            
            if let mss = (the_json.object(forKey: "streaming_source_live_show_matches") as? [String:Any])?["services"] as? [[String:Any]] {
                let servicesWithNotification  = mss
                
                servicesWithNotification.forEach(){ src in
                    if let mlss: MatchedLiveStreamingSourceSerivce = MatchedLiveStreamingSourceSerivce.init(json: src){
                        self.matchedLiveStreamingServices.append(mlss)
                    }
                }
                
                self.uniqueMatchedLiveStreamingServices  = $.uniq(self.matchedLiveStreamingServices){ $0.appIdentifier }
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
        
        let uri = self.channel.now_playing.preferredImage["uri"]
        let url = URL(string: uri! as! String)
        
        backgroundImage.sd_setImage(with: url!)
        
        genres.text = $.join(media.genres as! [String], separator: " | ")
        
        
        
        //
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func updateProgress() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mmzzz"
        let startString = media.start_time.replacingOccurrences(of: "Z", with: "UTC")
        let endString = media.end_time.replacingOccurrences(of: "Z", with: "UTC")
        
        let start = dateFormatter.date(from: startString)
        let end = dateFormatter.date(from: endString)
        
        let difference = Date().timeIntervalSince(start!)
        let totalRunTime = end?.timeIntervalSince(start!)
        
        let progress = difference/totalRunTime!
        
        
        showProgress.progress = Float(progress)
        //        elapsedTime.text = "\(showProgress.progress)"
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.tabBarController?.tabBar.isHidden = true
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(LiveDetailsViewController.updateProgress), userInfo: nil, repeats: true)
        self.timer.fire()
        
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
        
        return self.uniqueMatchedLiveStreamingServices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "app_icons", for: indexPath) as! AppCell
        
        //this needs to be hooked up
        
        //        let source = sources[indexPath.row]
        
        let source = uniqueMatchedLiveStreamingServices[indexPath.row]
        
        cell.service = source
        cell.presenter = self
        cell.showName = media.title
        cell.image.image = UIImage(named:"\(source.appIdentifier!)")
        cell.backgroundColor = Common.getRandomColor()
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.white.cgColor
        return cell
    }
    
    //MARK: - Collection View Data Source
    
    let application = UIApplication.shared
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let cell = collectionView.cellForItem(at: indexPath) as! AppCell
        cell.prepareForDeepLink(service: cell.service)
        
        //        print("\(indexPath) clicked")
        //
        //        let source = sources[indexPath.row]
        //
        //        let link = getDeepLink(deepLinks: source.deep_links as! [String])
        //
        //        if link != "" {
        //            application.openURL(URL.init(string: link)!)
        //
        //        } else {
        //
        //            application.openURL(URL.init(string: source.app_store_link)!)
        //        }
        
        
        
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

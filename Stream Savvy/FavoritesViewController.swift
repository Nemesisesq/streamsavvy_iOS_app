//
//  FavoritesViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 9/16/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit
import PromiseKit
import Dollar
import MBProgressHUD
import Crashlytics

class FavoritesViewController: Auth0ViewController, iCarouselDataSource, iCarouselDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var numbers = [String]()
    var selectedShow: Content!
    let searchResults = SearchResults()
    let favorites = Favorites()
    var searchButton: UIBarButtonItem!
    
    var recommendations: [Content]!{
        didSet{
            var sorted: [Content]! = self.recommendations.sorted {
                $0.curr_pop_score > $1.curr_pop_score
            }
            
            sorted = $.uniq(sorted)
            
            self.recommendations = sorted
            recommendationCollectionView.reloadData()
        }
    }
    
    
    @IBOutlet var recommendationCollectionView: UICollectionView!
    @IBOutlet var carousel: iCarousel!
    @IBOutlet var emptyLabel: UILabel!
    
    @IBAction func search(_ sender: UIBarButtonItem) {
        //Here we set the search bar and the results table
        (self.navigationController as! SearchNavigationControllerViewController).search()
    }
    
    override func loadView() {
        super.loadView()
        //        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        Answers.logContentView(withName: "Favorites", contentType: "Shows", contentId: "", customAttributes: [:])
        makeCarousel()
        
        
        _ = favorites.fetchFavorites().then{ result -> Void in
            
            self.favorites.contentList = self.favorites.contentList.reversed()
            
            if self.favorites.contentList.count > 0 {
                
            }
            
            self.carousel.reloadData()
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationImageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 200, height: 34))
        
        navigationImageView.image = #imageLiteral(resourceName: "streamsavvy-wordmark-large")
        navigationImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = navigationImageView
        
        recommendations = [Content]()
        
        Auth0.calledBySubclass = true
        //carousel.type = .cylinder
        // Do any additional setup after loading the view.
        
        searchButton = UIBarButtonItem.init(barButtonSystemItem: .search, target:self , action: #selector(self.search(_:)))
        searchButton.tintColor  = Constants.streamSavvyRed()
        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        openSocket()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //        socket.ws.close()
    }
    
    override func viewDidLayoutSubviews() {
        // carousel.currentItemIndex = -1
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let item = carousel.currentItemView as? CarouselItem {
            return self.recommendations.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Recommendation", for: indexPath) as! RecommendationCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! RecommendationCollectionViewCell
        let item = carousel.currentItemView as! CarouselItem
        if let reco = self.recommendations {
            cell.content =  reco[indexPath.row]
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! RecommendationCollectionViewCell
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContentDetailViewController") as! ContentDetailViewController
        vc.content = cell.content
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    func makeCarousel() {
        carousel.type = .linear
        //                print("viewWillAppear")
        //                print(self.view.subviews)
        //        self.carousel.delegate = self
        //        self.carousel.dataSource = self
        
    }
    
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        //        print("number of favorites: \(favorites.contentList.count)")
        return favorites.contentList.count
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        
        
        if option == iCarouselOption.spacing {
            return value * 1.0
        }
        
        if option == iCarouselOption.wrap {
            return 1.0
        }
        
        if option == iCarouselOption.fadeMin{
            
        }
        if option == iCarouselOption.fadeMax {
            
        }
        if option == iCarouselOption.fadeRange{
            
        }
        if option == iCarouselOption.fadeMinAlpha {
            
        }
        return value
    }
    
    
    func getRandomColor() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        /*
         here the content for the carousel can be set. a carousel item is created and sub views can be added to that item
         */
        let carouselItemView = CarouselItem.instantiateFromNib()
        carouselItemView.frame = CGRect(
            x: 0,
            y: 0,
            width: carousel.frame.size.width * 0.7 ,
            height: carousel.frame.size.height * 0.9)
        
        SDWebModel.loadImage(for: carouselItemView.showImage, withRemoteURL: favorites.contentList[index].image_link)
        
        carouselItemView.showImage.contentMode = .scaleAspectFit
        carouselItemView.showImage.clipsToBounds = false
        
        //                carouselItemView.showTitle.text = favorites.contentList[index].title
        carouselItemView.vc = self
        carouselItemView.index = index
        carouselItemView.content = favorites.contentList[index]
        
        return carouselItemView
        
    }
    
    var debounceTimer: Timer?
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index:Int){
        performSegue(withIdentifier: "FavContentDetailSegue", sender: self)
        
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        if let item = carousel.currentItemView as? CarouselItem{
            if let s = item.socket?.ws {
                s.close()
            }
            
        }
        
        
    }
    
    func carouselDidScroll(_ carousel: iCarousel) {
        if let timer = debounceTimer{
            timer.invalidate()
        }
        
        if recommendations != nil {
            recommendations.removeAll()
        }
        
        if #available(iOS 10.0, *) {
            debounceTimer = Timer.init(timeInterval: 0.3, repeats: false, block: { (Timer) in
                if let item = carousel.currentItemView as? CarouselItem{
                    item.isActive = true
                    item.getRecommendations()
                }
                
            })
        } else {
            // Fallback on earlier versions
        }
        RunLoop.current.add(debounceTimer!, forMode: .defaultRunLoopMode)
    }
    
    func showEpisodes() {
        self.performSegue(withIdentifier: "EpisodeSegue", sender: self)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ContentDetailSegue" || segue.identifier == "FavContentDetailSegue"  {
            let cdvc = segue.destination as! ContentDetailViewController
            let current = carousel.currentItemView as? CarouselItem
            cdvc.content = current?.content
            
            cdvc.favorites = favorites
            
            
        }else if segue.identifier == "EpisodeSegue" {
            
            let ecvc = segue.destination as! EpisodeCollectionViewController
            ecvc.content = favorites.contentList[self.carousel.currentItemIndex]
            
        }
    }
    
}

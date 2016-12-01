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


class FavoritesViewController: Auth0ViewController, iCarouselDataSource, iCarouselDelegate, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate {
        //        let constants = Constants()
        var numbers = [String]()
        var selectedShow: Content!
        let searchResults = SearchResults()
        let favorites = Favorites()
               var resultsController: UITableViewController!
        var searchController: UISearchController!
    
    var searchButton: UIBarButtonItem!
        @IBOutlet var carousel: iCarousel!
        @IBOutlet var emptyLabel: UILabel!

        
        
        @IBAction func search(_ sender: UIBarButtonItem) {
                //Here we set the search bar and the results table
                (self.navigationController as! SearchNavigationControllerViewController).search()
    }
        
        
        
        func numberOfSections(in tableView: UITableView) -> Int {
                return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return searchResults.results.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
                if searchResults.results.count  > 0 {
                        let sug = searchResults.results[indexPath.row]
                        
                        cell.textLabel?.text = sug.title
                        cell.detailTextLabel?.text = "detail?"
                }
                return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                selectedShow = searchResults.results[indexPath.row]
                
                                        self.searchController.isActive = false
                        self.performSegue(withIdentifier: "ContentDetailSegue", sender: self)

                        
                
                
                
                
        }
        
        func updateSearchResults(for searchController: UISearchController) {
                if (searchController.searchBar.text!.isEmpty != true ){
                        //            searchResults.results.removeAll()
                        
                        _ = searchResults.fetchResults(q: searchController.searchBar.text!)
                                .then{result -> Void in
                                        
                                        self.resultsController.tableView.reloadData()
                                        
                        }
                }
                
        }
        
        
        override func loadView() {
                super.loadView()
                //        view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(animated)
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
            
            Auth0.calledBySubclass = true
                //carousel.type = .cylinder
                // Do any additional setup after loading the view.
            
            
            
            searchButton = UIBarButtonItem.init(barButtonSystemItem: .search, target:self , action: #selector(self.search(_:)))
            searchButton.tintColor  = Constants.streamSavvyRed()
            self.navigationItem.rightBarButtonItem = searchButton
            
            
            
            
                //        self.navigationItem.hidesBackButton = true
                //        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
                //        self.navigationItem.leftBarButtonItem = newBackButton;
                
                
                
        }
        
        override func viewDidAppear(_ animated: Bool) {
                if (self.searchController != nil) {
                        //            self.searchController.isActive = true
                       
                }
                
        }
        
        override func viewDidLayoutSubviews() {
//              carousel.currentItemIndex = -1
        }
        
        
        func back(sender: UIBarButtonItem) {
                // Perform your custom actions
                // ...
                // Go back to the previous ViewController
                //        self.navigationController?.popViewController(animated: true)
        }
        
        
        override func awakeFromNib() {
                super.awakeFromNib()
        }
        
        
        override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
        }
        
        
        func makeCarousel() {
                carousel.type = .linear
//                print("viewWillAppear")
//                print(self.view.subviews)
                self.carousel.delegate = self
                self.carousel.dataSource = self
                
        }
        
        
        func numberOfItems(in carousel: iCarousel) -> Int {
                //        print("number of favorites: \(favorites.contentList.count)")
                return favorites.contentList.count
        }
        
        func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
                
        
                if option == iCarouselOption.spacing {
                        return value * 1.0
                }
                return value
        }
        
        
        func getRandomColor() -> UIColor{
                let randomRed:CGFloat = CGFloat(drand48())
                let randomGreen:CGFloat = CGFloat(drand48())
                let randomBlue:CGFloat = CGFloat(drand48())
                return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.1)
        }
        
        
        func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
                /*
                 here the content for the carousel can be set. a carousel item is created and sub views can be added to that item
                 */
                let carouselItemView = CarouselItem.instantiateFromNib()
                carouselItemView.frame = CGRect(
                        x: 0,
                        y: 0,
                        width: carousel.frame.size.width * 0.75 ,
                        height: carousel.frame.size.height * 0.9)
                
                SDWebModel.loadImage(for: carouselItemView.showImage, withRemoteURL: favorites.contentList[index].image_link)
                
                carouselItemView.showImage.contentMode = .scaleAspectFit
                carouselItemView.showImage.clipsToBounds = false
                
                carouselItemView.showTitle.text = favorites.contentList[index].title
                carouselItemView.vc = self
                carouselItemView.index = index
                carouselItemView.content = favorites.contentList[index]
                
                return carouselItemView
                
        }
        
        func showEpisodes() {
                self.performSegue(withIdentifier: "EpisodeSegue", sender: self)
        }
        
        
        // MARK: - Navigation
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                
                if segue.identifier == "ContentDetailSegue" {
                        let cdvc = segue.destination as! ContentDetailViewController
                        cdvc.content = selectedShow
                        cdvc.favorites = favorites  
                        
                        
                }else if segue.identifier == "EpisodeSegue" {
                        
                        let ecvc = segue.destination as! EpisodeCollectionViewController
                        ecvc.content = favorites.contentList[self.carousel.currentItemIndex]
                        
                }
        }
        
}

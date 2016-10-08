//
//  FavoritesViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 9/16/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit
import PromiseKit


class FavoritesViewController: UIViewController, iCarouselDataSource, iCarouselDelegate, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate {
    
    var numbers = [String]()
    var selectedShow: Content!
    let searchResults = SearchResults()
    let favorites = Favorites()
    @IBOutlet var carousel: iCarousel!
    var resultsController: UITableViewController!
    var searchController: UISearchController!
    
    
    @IBAction func search(_ sender: UIBarButtonItem) {
        //Here we set the search bar and the results table
        resultsController = UITableViewController(style: .plain)
        resultsController.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ResultCell")
        resultsController.tableView.dataSource = self
        resultsController.tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsController)
        //        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchResultsUpdater = self
        

        self.searchController.hidesNavigationBarDuringPresentation = false;
        self.definesPresentationContext = false;
        
        self.present(searchController, animated:true, completion: { print("Done")})
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
//        print("###########")
        print(selectedShow)
        //	self.searchController.dismiss(animated: true, completion: nil)
        self.searchController.isActive = false
        self.performSegue(withIdentifier: "ContentDetailSegue", sender: self)
        
        /*
         let cdvc = storyboard?.instantiateViewController(withIdentifier: "ContentDetailViewController") as! ContentDetailViewController
         cdvc.content = selectedShow
         
         self.navigationController?.pushViewController(cdvc, animated: true)
         */
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if (searchController.searchBar.text!.isEmpty != true ){
            //            searchResults.results.removeAll()
            
            searchResults.fetchResults(q: searchController.searchBar.text!)
                .then{result -> Void in
                    //                    print(result)
                    self.resultsController.tableView.reloadData()
                    
                    //                    return result as! AnyPromise
            }
        }
        //        print(searchController.searchBar.text!)
    }
    
    
    override func loadView() {
        super.loadView()
//        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        makeCarousel()
        

        favorites.fetchFavorites().then{ result -> Void in
            print("fetchFavorites() success")
            //            print(result)
            print(self.carousel.isHidden)
            print(self.carousel.layer.zPosition)
            self.carousel.reloadData()
            
        }
        
    }
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
        //carousel.type = .cylinder
        // Do any additional setup after loading the view.
        
        //        self.navigationItem.hidesBackButton = true
        //        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        //        self.navigationItem.leftBarButtonItem = newBackButton;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (self.searchController != nil) {
            //            self.searchController.isActive = true
            print(self.carousel.isHidden)
            print(self.carousel.layer.zPosition)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        if (self.searchController != nil) {
            //            self.searchController.isActive = true
        }
        
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
        carousel.type = .cylinder
        print("viewWillAppear")
        print(self.view.subviews)
        self.carousel.delegate = self
        self.carousel.dataSource = self

    }
    
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        //        print("number of favorites: \(favorites.contentList.count)")
        return favorites.contentList.count
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.spacing {
            return value * 1.2
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
         here the content for the carousel can be set. a carousel item is crreatec and sub views can be added to that item
         */
        let carouselItemView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.size.width * 0.9,
            height: 400));
        
        
        carouselItemView.backgroundColor = getRandomColor()
        
        /*
         
         example here we create a button  and center it inside of the carousel item view
         */
	let backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width:carouselItemView.frame.size.width, height: carouselItemView.frame.size.height));
	backgroundImageView.contentMode = UIViewContentMode.scaleAspectFill
	backgroundImageView.clipsToBounds = true
	SDWebModel.loadImage(for: backgroundImageView, withRemoteURL: favorites.contentList[index].image_link)
//	backgroundImageView.backgroundColor = UIColor.black
	
	let overLayImageView = UIImageView(frame: CGRect(x: 0, y: 0, width:carouselItemView.frame.size.width, height: carouselItemView.frame.size.height));
	overLayImageView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
	
        let button = UIButton(frame: CGRect(x: 0, y: 20, width: self.view.frame.size.width * 0.9, height: 40));
        
        //        button.center = CGPoint(x: carouselItemView.frame.size.width  / 2,
        //                                y: (carouselItemView.frame.size.height / 2))
        
        button.backgroundColor = UIColor.clear
        button.tintColor = UIColor.red
        button.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: 1)
        
        let newButton = UIButton(frame: CGRect(x: 0, y: 80, width: self.view.frame.size.width * 0.9, height: 40));
        
        //        button.center = CGPoint(x: carouselItemView.frame.size.width  / 2,
        //                                y: (carouselItemView.frame.size.height / 2))
        
       
        newButton.backgroundColor = UIColor.gray
        newButton.tintColor = UIColor.red
        newButton.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: 1)
        newButton.setTitle("Watch Episodes", for: .normal)
        
        let margins = carouselItemView.layoutMarginsGuide
        
//        newButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 20.0).isActive = true
        
        newButton.addTarget(self, action: #selector(showEpisodes), for: UIControlEvents.touchUpInside)
        
        
        button.setTitle(favorites.contentList[index].title, for: .normal)
	
	carouselItemView.addSubview(backgroundImageView)
	carouselItemView.addSubview(overLayImageView)
        carouselItemView.addSubview(button)
        carouselItemView.addSubview(newButton)
        
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
            //self.searchController.isActive = false
            
	}else if segue.identifier == "EpisodeSegue" {
		print("EpisodeSegue")
		print(favorites.contentList[self.carousel.currentItemIndex].title)
		let ecvc = segue.destination as! EpisodeCollectionViewController
		ecvc.content = favorites.contentList[self.carousel.currentItemIndex]
		print("\n\n\n~")
		print(ecvc.content.guidebox_data)
	}
    }
	
}

//
//  FavoritesViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 9/16/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit


class FavoritesViewController: UIViewController, iCarouselDataSource, iCarouselDelegate, UISearchResultsUpdating {
    
    var numbers = [Int]()
    
    let searchResults = SearchResults()
    
    @IBOutlet var carousel: iCarousel!
    
    @IBAction func search(_ sender: UIBarButtonItem) {
        //Here we set the search bar and the results table
        let resultsController = UITableViewController(style: .plain)
        let searchController = UISearchController(searchResultsController: resultsController)
        self.present(searchController, animated:true, completion: nil)
        
        searchController.searchResultsUpdater = self
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if (searchController.searchBar.text?.isEmpty != true ){
           searchResults.fetchResults(q: searchController.searchBar.text!)
        }
        
//        print(searchController.searchBar.text!)
    }
    
    override func loadView() {
        super.loadView()
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        carousel.type = .cylinder
        // Do any additional setup after loading the view.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        numbers = [1,2,3,4,5,7,8]
        //
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return numbers.count
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.spacing {
            return value * 1.2
        }
        
        return value
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        /*
         here the content for the carousel can be set. a carousel item is crreatec and sub views can be added to that item
         */
        
        let carouselItemView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 400));
        
        carouselItemView.backgroundColor = UIColor.blue
        
        /*
         
         example here we create a button  and center it inside of the carousel item view
         */
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100));
        
        button.center = CGPoint(x: carouselItemView.frame.size.width  / 2,
                                y: carouselItemView.frame.size.height / 2)
        
        button.backgroundColor = UIColor.red
        
        button.setTitle("\(index)", for: .normal)
        
        carouselItemView.addSubview(button);
        
        return carouselItemView
        
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

//
//  SearchNavigationControllerViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/29/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit
import MBProgressHUD
import Crashlytics

@objc class SearchNavigationControllerViewController: UINavigationController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,UISearchControllerDelegate {
    var selectedShow: Content!
    let searchResults = SearchResults()
    var resultsController: UITableViewController!
    var searchController: UISearchController!
    var favorites =  Favorites()
    var blurEffect: UIBlurEffect!
    var blurEffectView: UIVisualEffectView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    func search() {
        //Here we set the search bar and the results table
        resultsController = UITableViewController(style: .plain)
        resultsController.tableView.register(UINib.init(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultCell")
        resultsController.tableView.dataSource = self
        resultsController.tableView.delegate = self
        resultsController.tableView.backgroundColor = .clear
        //        resultsController.tableView.separatorStyle = .none
        
        searchController = UISearchController(searchResultsController: resultsController)
        //        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchResultsUpdater = self
        searchController.searchBar.barTintColor = .black
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.keyboardAppearance = .dark
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        blurEffectView.alpha = 0.0
        view.addSubview(blurEffectView)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.blurEffectView.alpha = 1.0
        })
        
        self.searchController.hidesNavigationBarDuringPresentation = false;
        self.definesPresentationContext = true;
        
        self.present(searchController, animated:true, completion: { print("Done")})
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! SearchResultTableViewCell
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedShow = searchResults.results[indexPath.row]
        
        self.searchController.isActive = false
        self.performSegue(withIdentifier: "ContentDetailSegue", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if searchResults.results.count  > 0 {
            let sug = searchResults.results[indexPath.row]
            if let postCell = cell as? SearchResultTableViewCell {
                postCell.title.text = sug.title
                //                postCell.backgroundImageView?.sd_setImage(with: URL(string: sug.image_link))
                
            }
            
        }
    }
    
    
    var debounceTimer: Timer?
    
    func fetch(text:String){
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "searching.."
        
        _ = searchResults.fetchResults(q: text)
            .then{result -> Void in
                
                self.resultsController.tableView.reloadData()
                MBProgressHUD.hide(for: self.view, animated: true)
                
                
            }.catch{_ in
                MBProgressHUD.hide(for: self.view, animated: true)
                MBProgressHUD.hideAllHUDs(for: self.view, animated: true)

                
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let timer = debounceTimer{
            timer.invalidate()
        }
        if (searchController.searchBar.text!.isEmpty != true ){
            //            searchResults.results.removeAll()
            
            if #available(iOS 10.0, *) {
                debounceTimer = Timer.init(timeInterval: 0.3, repeats: false, block: { (Timer) in
                    Answers.logSearch(withQuery: "mobile analytics", customAttributes: ["query": searchController.search.text!])
                    self.fetch(text: searchController.searchBar.text!)
                })
            } else {
                // Fallback on earlier versions
            }
            RunLoop.current.add(debounceTimer!, forMode: .defaultRunLoopMode)
        } else {
            searchResults.results.removeAll(keepingCapacity: true)
        }
        
    }
    
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3, animations: {
            self.blurEffectView.alpha = 0.0
            self.tabBarController?.tabBar.alpha = 1.0
        }, completion: {(Bool) -> Void in
            self.blurEffectView.removeFromSuperview()
            
        })
        
    }
    
    
    
    
    func didDismissSearchController(_ searchController: UISearchController) {
        MBProgressHUD.hide(for: self.view, animated: true)

        UIView.animate(withDuration: 0.3, animations: {
            self.blurEffectView.alpha = 0.0
            self.tabBarController?.tabBar.alpha = 1.0
        }, completion: {(Bool) -> Void in
            self.blurEffectView.removeFromSuperview()
            
        })
        
        
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ContentDetailSegue" {
            let cdvc = segue.destination as! ContentDetailViewController
            cdvc.content = selectedShow
            cdvc.favorites = Favorites()
            
            
        }
    }
    
    
    
}

//
//  SearchNavigationControllerViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/29/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit

class SearchNavigationControllerViewController: UINavigationController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate {
    let searchResults = SearchResults()
    var resultsController: UITableViewController!
    var searchController: UISearchController!
    var searchButton: UIBarButtonItem!


    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    
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



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

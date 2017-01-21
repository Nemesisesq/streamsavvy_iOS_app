//
//  FavoritesTableViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 1/17/17.
//  Copyright © 2017 StreamSavvy. All rights reserved.
//

import UIKit
import Gloss


class TableFav: Decodable {
    var name: String!
//    var img: String!
    
    
    required init(json: JSON)  {
        name = "name" <~~ json
//        img = "img" <~~ json
    }
}

class FavsTableCell: UITableViewCell {
    
    var fav: TableFav! {
        didSet{
            name.text = fav.name
        }
    }
    
    @IBOutlet var name: UILabel!
    
}

class FavoritesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let favorites = Favorites.sharedInstance
    var favs = [TableFav]()
    
    @IBOutlet var favoriteTable: UITableView!
    
    @IBAction func search(_ sender: UIBarButtonItem) {
        //Here we set the search bar and the results table
        (self.navigationController as! SearchNavigationControllerViewController).search()
    }
    
     var searchButton: UIBarButtonItem!

    
    override func viewWillAppear(_ animated: Bool) {
        
        favs = favorites.favs
        
        self.favoriteTable.reloadData()
    

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let navigationImageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 200, height: 34))
        
        navigationImageView.image = #imageLiteral(resourceName: "streamsavvy-wordmark-large")
        navigationImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = navigationImageView

        Auth0.calledBySubclass = true
        //carousel.type = .cylinder
        // Do any additional setup after loading the view.
        
        searchButton = UIBarButtonItem.init(barButtonSystemItem: .search, target:self , action: #selector(self.search(_:)))
        searchButton.tintColor  = Constants.streamSavvyRed()
        self.navigationItem.rightBarButtonItem = searchButton

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favs.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavsTableCell
        
        // Configure the cell...
    
        
        cell.fav = favs[indexPath.row]
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

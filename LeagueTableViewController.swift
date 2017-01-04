//
//  LeaugeTableViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 1/3/17.
//  Copyright © 2017 StreamSavvy. All rights reserved.
//

import UIKit
import Gloss

class Organization: Decodable {
    var organization : String!
    var imageURL : String!
    var id : String!
    
    required init?(json: JSON) {
        organization = "organization" <~~ json
        imageURL = "img" <~~ json
        id = "gracenote_organization_id" <~~ json
        
    }
}

class LeagueTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var orgs: [Organization]! = [Organization]()
    
    var orgList: [[String: Any]]! {
        didSet{
            for i in orgList {
               orgs.append(Organization.init(json: i)!)
            }
            
        }
    }
    
    @IBOutlet var tv: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return orgs.count
    }
    
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! LeagueTableViewCell
        
        let org = orgs[indexPath.row]
        
        cell.org = org
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let org = orgs[indexPath.row]
        
        
        
        
        let q = GraphQLAPI.teamsForOrgQuery(id: org.id).create()
        
         _ = GraphQLAPI.fetchGraphQLQuery(q: q)
           .then{ the_json -> Void in
        
             let vc: TeamTableViewController = UIStoryboard(name: "SetUp", bundle: nil).instantiateViewController(withIdentifier: "TeamTableViewController") as! TeamTableViewController
                        vc.teams = the_json["data"]?["teams"] as! [[String: Any]]
            
            if vc.teams.count > 0 {
                self.navigationController?.pushViewController(vc, animated: true)

            } else {
                self.addLeaugeToFavorites()
            }
            
            }
        
        
        
        
    }
    
    func addLeaugeToFavorites(){
        
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

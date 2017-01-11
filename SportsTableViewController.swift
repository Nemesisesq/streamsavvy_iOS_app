//
//  SetupTableViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 12/28/16.
//  Copyright © 2016 StreamSavvy. All rights reserved.
//

import UIKit
import Gloss
import PromiseKit

class Sport: Decodable {
    let sportsId: String!
    let sportsName: String!
    
    required init?(json: JSON) {
        sportsId = "sportsId" <~~ json
        sportsName = "sportsName" <~~ json
    }
}

class SetupTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sportsList: [Sport]!
    var chosenSport: Sport!
    @IBOutlet var setupTableView: UITableView!
    
    @IBAction func launchApp(_ sender: Any) {
        
        
        
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnDemandViewController")
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let q = GraphQLAPI.sportQuery.create()
        
        print(q)
        sportsList = [Sport]()
        _ =  GraphQLAPI.fetchGraphQLQuery(q: q)
            .then{ the_json -> Void in
                print(the_json)
                let data = the_json["data"] as! [String:Any]
                let sports = data["sports"] as! [[String:Any]]
                
                sports.forEach { x in
                    
                    self.sportsList.append(Sport.init(json: x)!)
                    
                }
                
                self.setupTableView.reloadData()
                
        }
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
        return sportsList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        
//        cell.backgroundColor = Common.getRandomColor()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! SetupTableViewCell
        cell.sport = sportsList[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SetupTableViewCell
        chosenSport = sportsList[indexPath.row]
        
        
        firstly {
            goToOrgView()
            }
            .then {r -> Promise<Bool> in
                
                if !r {
                    return self.goToTeamsView()
                }
                
                return Promise.init(value: false)
            }.then { r -> Void in
                
                let q = GraphQLAPI.toggleSport(sport: self.chosenSport, fav: !cell.fav).create()
                print(q)
                
                _ = GraphQLAPI.fetchGraphQLQuery(q: q)
                    .then { the_json -> Void in
                        
                        if let t = the_json["data"] as? [String: [String: Any]]{
                            cell.fav = t["toggleSport"]?["status"] as! Bool
                            cell.isHighlighted = true
                            
                        }

                }

                
               
            }.catch{ error in
                return
        }
    }
    
    func addSportToFavorites(sport : Sport){
            }
    
    func goToTeamsView() -> Promise<Bool> {
        let q = GraphQLAPI.teamsForSportQuery(id: chosenSport.sportsId).create()
        
        return GraphQLAPI.fetchGraphQLQuery(q: q)
            .then{ the_json -> Bool in
                
                let vc: TeamTableViewController = UIStoryboard(name: "SetUp", bundle: nil).instantiateViewController(withIdentifier: "TeamTableViewController") as! TeamTableViewController
                vc.teams = the_json["data"]?["teams"] as! [[String: Any]]
                
                if vc.teams.count > 1 {
//                self.present(vc, animated: true, completion: nil)
                self.navigationController?.pushViewController(vc, animated: true)
                return false
                } else {
                    return true
                }
                
        }
    }
    
    func goToOrgView() -> Promise<Bool> {
        let xq = GraphQLAPI.leaguesForSportQuery(id: chosenSport.sportsId).create()
        return GraphQLAPI.fetchGraphQLQuery(q: xq)
            .then{ the_json -> Bool in
                print(the_json)
                let vc: LeagueTableViewController = UIStoryboard(name: "SetUp", bundle: nil).instantiateViewController(withIdentifier: "LeagueTableViewController") as! LeagueTableViewController
                
                
                let o = the_json["data"]?["orgs"] as! [[String: Any]]
                
                if o.count > 1 {
                    vc.orgList = o
                   self.navigationController?.pushViewController(vc, animated: true)
                    
                    return true
                }
                
                return false
        }
        
        
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}

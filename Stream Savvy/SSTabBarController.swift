//
//  SSTabBarController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/27/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit
import MBRateApp

class SSTabBarController: UITabBarController, Auth0Protocol {
    
    var hasIdToken: Bool? = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            _ =  try checkForIdToken(keychain: Auth0.keychain, controller: Auth0.controller, vc: self)
            hasIdToken = true
        } catch MyError.Null {
            print("there is no token")
            hasIdToken = false
        } catch {
            print("something else went wrong")
        }
        
        // Do any additional setup after loading the view.
        
        if let items = tabBar.items {
            items[2].isEnabled = hasIdToken!
            items[3].isEnabled = hasIdToken!
        }
        
        //Application rating via MBRate
        var rateUsInfo = MBRateUsInfo()
        
        rateUsInfo.title = "Enjoying Streamsavvy?"
        rateUsInfo.titleImage = #imageLiteral(resourceName: "marks_streamsavvy_mark_large")
        rateUsInfo.itunesId = "1148176910"
        MBRateUs.sharedInstance.rateUsInfo = rateUsInfo
        
        
        
    }
    
    func showRating() {
        MBRateUs.sharedInstance.showRateUs(self
            , positiveBlock: { () -> Void in
                let alert = UIAlertController(title: "MBAppRate", message: "User rated the app", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }, negativeBlock: { () -> Void in
            let alert = UIAlertController(title: "MBAppRate", message: "User doesn't like the app", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }) { () -> Void in
            let alert = UIAlertController(title: "MBAppRate", message: "User dismissed screen", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do {
            _ =  try checkForIdToken(keychain: Auth0.keychain, controller: Auth0.controller, vc: self)
            hasIdToken = true
        } catch MyError.Null {
            print("there is no token")
            hasIdToken = false
        } catch {
            print("something else went wrong")
        }
        
        
        
        
        // Do any additional setup after loading the view.
        
        if let items = tabBar.items {
            items[2].isEnabled = hasIdToken!
            items[3].isEnabled = hasIdToken!
        }
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "favorites" || identifier == "profile"{
            return hasIdToken!
        }
        return true
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

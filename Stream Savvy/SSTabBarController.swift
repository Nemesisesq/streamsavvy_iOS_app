//
//  SSTabBarController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/27/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit

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

//
//  ProfileViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/25/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit
import Lock
import SimpleKeychain


class ProfileTableViewController: UITableViewController, Auth0Protocol {
        
        var keychain = A0SimpleKeychain(service: "Auth0")
        
        var client = A0Lock.shared().apiClient()
        
        var controller = A0Lock.shared().newLockViewController()
        
        @IBOutlet var emailTextField: UITextField!
        
        @IBOutlet var nicknameTextField: UITextField!
        
        @IBOutlet var profileImageView: UIImageView! {
                didSet{
                        profileImageView.layer.cornerRadius = 50
                        profileImageView.layer.masksToBounds = true
                }
        }
        
        
        @IBAction func logout(_ sender: AnyObject) {
                keychain.clearAll()
                
        }
        override func viewDidLoad() {
                super.viewDidLoad()
                
                // Do any additional setup after loading the view.
                guard let idToken = keychain.string(forKey: "id_token") else {
                        // idToken doesn't exist, user has to enter his credentials to log in
                        // Present A0Lock Login
                        A0Lock.shared().present(controller, from: self)
                        return
                }
        }
        
        override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
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

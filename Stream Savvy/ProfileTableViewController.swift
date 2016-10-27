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


class ProfileTableViewController: UITableViewController {
        
        let keychain = A0SimpleKeychain(service: "Auth0")
        
        let client = A0Lock.shared().apiClient()
        
        let controller = A0Lock.shared().newLockViewController()
        
        
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
        
        client.fetchUserProfile(withIdToken: idToken,
                                success: { profile in
                                        // Our idToken is still valid...
                                        // We store the fetched user profile
                                        self.keychain.setData(NSKeyedArchiver.archivedData(withRootObject: profile), forKey: "profile")
                                        // ✅ At this point, you can log the user into your app,
                                        
                                        self.emailTextField.text = profile.email
                                        self.nicknameTextField.text = profile.nickname
                                        
                                        self.profileImageView.sd_setImage(with: profile.picture)
                                        return
                                        
                                        
                                        
                                        
                },
                                failure: { error in
                                        // ⚠️ idToken has expired or is no longer valid
                                        // See step 4
                                        
                                        guard let refreshToken = self.keychain.string(forKey: "refresh_token") else {
                                                self.keychain.clearAll()
                                                
                                                // ⛔️ At this point, you should ask the user to enter his credentials again!
                                                A0Lock.shared().present(self.controller, from: self)
                                                return
                                        }
                                        
                                        self.client.fetchNewIdToken(withRefreshToken: refreshToken,
                                                               parameters: nil,
                                                               success: {newToken in
                                                                
                                                                self.keychain.setString(newToken.idToken, forKey: "id_token")
                                                                
                                                                // ✅ At this point, you can log the user into your app, by navigating to the corresponding screen
                                                },
                                                               failure: { error in
                                                                
                                                                // refreshToken is no longer valid (e.g. it has been revoked)
                                                                // Cleaning stored values since they are no longer valid
                                                                
                                                                self.keychain.clearAll()
                                                                
                                                                // ⛔️ At this point, you should ask the user to enter his credentials again!
                                                                
                                        })
                                        
                                        
        })
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

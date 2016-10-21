//
//  Auth0ViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/20/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit
import Lock
import SimpleKeychain
import PromiseKit

class Auth0ViewController: UIViewController {
        
        var loginComplete: Bool?
        
        
        
        override func viewDidLoad() {
                super.viewDidLoad()
                
                
                // Do any additional setup after loading the view.
        }
        
        
        
        override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
        }
        
        override func viewWillAppear(_ animated: Bool) {
                
        }
        override func viewDidAppear(_ animated: Bool) {
                
                
                let keychain = A0SimpleKeychain(service: "Auth0")
                
                let controller = A0Lock.shared().newLockViewController()
                
                let client = A0Lock.shared().apiClient()
                
                controller?.closable = true
                
                controller?.onAuthenticationBlock = { profile, token in
                        // Do something with token  profile. e.g.: save them.
                        // Lock will not save these objects for you.
                        
                        UserPrefs.setToken(token?.accessToken)
                        UserPrefs.setEmail(profile?.email)
                        
                        guard
                                let token = token,
                                let refreshToken = token.refreshToken
                                else { return }
                        
                        let keychain = A0SimpleKeychain(service: "Auth0")
                        keychain.setString(token.idToken, forKey: "id_token")
                        keychain.setString(refreshToken, forKey: "refresh_token")
                        
                        
                        // Don't forget to dismiss the Lock controller
                        controller?.dismiss(animated: true, completion: nil)
                        
                        self.continueToApp()
                        //                                self.loginComplete = true
                        
                }
                
                
                
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
                                                keychain.setData(NSKeyedArchiver.archivedData(withRootObject: profile), forKey: "profile")
                                                // ✅ At this point, you can log the user into your app,
                                                self.continueToApp()
                                        
                                                
                                                
                                                
                        },
                                        failure: { error in
                                                // ⚠️ idToken has expired or is no longer valid
                                                // See step 4
                                                
                                                guard let refreshToken = keychain.string(forKey: "refresh_token") else {
                                                        keychain.clearAll()
                                                        
                                                        // ⛔️ At this point, you should ask the user to enter his credentials again!
                                                        A0Lock.shared().present(controller, from: self)
                                                        return
                                                }
                                                
                                                client.fetchNewIdToken(withRefreshToken: refreshToken,
                                                                       parameters: nil,
                                                                       success: {newToken in
                                                                        
                                                                        keychain.setString(newToken.idToken, forKey: "id_token")
                                                                        
                                                                        // ✅ At this point, you can log the user into your app, by navigating to the corresponding screen
                                                        },
                                                                       failure: { error in
                                                                        
                                                                        // refreshToken is no longer valid (e.g. it has been revoked)
                                                                        // Cleaning stored values since they are no longer valid
                                                                        
                                                                        keychain.clearAll()
                                                                        
                                                                        // ⛔️ At this point, you should ask the user to enter his credentials again!
                                                                        
                                                })
                                                
                                                
                })
                
                
                
                
                
                
                
                
        }
        
        func continueToApp() {
                if let mc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") {
                        self.present(mc, animated: true, completion: nil)
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

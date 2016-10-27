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

class Auth0ViewController: UIViewController, Auth0Protocol{
    
    
    let keychain = Auth0.keychain
    
    let controller = Auth0.controller
    
    let client = A0Lock.shared().apiClient()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        do {
//            _ =  try checkForIdToken(keychain: keychain, controller: controller, vc: self)
//            
//        } catch MyError.Null {
//            print("there is no token")
//            continueToApp(controller: controller, vc: self)
//        } catch {
//            print("something else went wrong")
//        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth0.userDismissed {
            return
        }
        
        
        
        controller.onUserDismissBlock = {
            if Auth0.userDismissed == false || Auth0.loggedIn == false {
                self.continueToApp(controller: self.controller, vc: self)
            }
            Auth0.userDismissed = true
            return
            
        }
        
        
        
        // TODO: Logic here is kind of broken
        
        
        guard let idToken = keychain.string(forKey: "id_token") else {
            // idToken doesn't exist, user has to enter his credentials to log in
            // Present A0Lock Login
            A0Lock.shared().present(controller, from: self)
            return
        }
        
        _ = fetchUserProfile(client: client, idToken: idToken, keychain: keychain, controller: controller)
            .then {result -> Void in
                
                if let profile = result as? A0UserProfile {
                    
                    // Our idToken is still valid...
                    // We store the fetched user profile
                    self.keychain.setData(NSKeyedArchiver.archivedData(withRootObject: profile), forKey: "profile")
                    // ✅ At this point, you can log the user into your app,
                    Auth0.loginComplete = true
                    
                    self.continueToApp(controller: self.controller, vc: self)
                    
                    
                    
                }
            }.catch { error in
                
                guard let refreshToken = self.keychain.string(forKey: "refresh_token") else {
                    // ⚠️ idToken has expired or is no longer valid
                    // See step 4
                    self.keychain.clearAll()
                    
                    // ⛔️ At this point, you should ask the user to enter his credentials again!
                    A0Lock.shared().present(self.controller, from: self)
                    
                    return
                }
                
                
                _ = self.fetchNewIdToken(controler: self.controller, client: self.client, refreshToken: refreshToken, keychain: self.keychain)
                    .then{ result -> Void in
                        if let x = result as? A0Token {
                            self.keychain.setString(x.idToken, forKey: "id_token")
                        }
                        
                        
                        self.continueToApp(controller: self.controller, vc: self)
                    }.catch {error in
                        
                        self.keychain.clearAll()
                        A0Lock.shared().present(self.controller, from: self)
                }
                
        }
        
    }
    
}

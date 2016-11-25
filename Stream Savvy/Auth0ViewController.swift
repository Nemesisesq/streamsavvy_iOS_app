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
import Crashlytics


@objc class Auth0ViewController: UIViewController, Auth0Protocol{
    
    var fromSegue: Bool = false {
        willSet {
            if newValue {
                Auth0.resetAll()
            }
        }
    }
    
    let keychain = Auth0.keychain
    
    let controller = Auth0.controller
    
    let client = A0Lock.shared().apiClient()
    
    func setFromSegue(bool:Bool){
        fromSegue = bool
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth0.calledBySubclass = false
        
        var dob = DateComponents()
        dob.day = 24
        dob.month = 5
        dob.year = 1992
        let d = NSCalendar.current.date(from: dob)
        let profile: Dictionary<String, AnyObject> = [
            "Name": "Jack Montana" as AnyObject,                 // String
            "Identity": 61026032 as AnyObject,                   // String or number
            "Email": "jack@gmail.com" as AnyObject,              // Email address of the user
            "Phone": "4155551234" as AnyObject,                    // Phone (without the country code)
            "Gender": "M" as AnyObject,                          // Can be either M or F
            "Employed": "Y" as AnyObject,                        // Can be either Y or N
            "Education": "Graduate" as AnyObject,                // Can be either School, College or Graduate
            "Married": "Y" as AnyObject,                         // Can be either Y or N
            "DOB": d! as AnyObject,                        // Date of Birth. An NSDate object
            "Age": 28 as AnyObject,                              // Not required if DOB is set
            "Photo": "www.foobar.com/image.jpeg" as AnyObject,   // URL to the Image
            
            // optional fields. controls whether the user will be sent email, push etc.
            "MSG-email": false as AnyObject,                     // Disable email notifications
            "MSG-push": true as AnyObject,                       // Enable push notifications
            "MSG-sms": false as AnyObject                       // Disable SMS notifications
        ]
        
        CleverTap.sharedInstance()?.profilePush(profile)
        CleverTap.sharedInstance()?.recordEvent("mock profile set")
        
        
        // Do any additional setup after loading the view.
    }
    
    func logUser(email: String, id: String, username: String) {
        // TODO: Use the current user's information
        // You can call any combination of these three methods
        Crashlytics.sharedInstance().setUserEmail(email)
        Crashlytics.sharedInstance().setUserIdentifier(id)
        Crashlytics.sharedInstance().setUserName(username)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //        if Auth0.userDismissed {
        //            Auth0.userDismissed = false
        //        }
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
                    // TODO: Move this to where you establish a user session
                    
                    let em = profile.email ?? "none"
                    let id = profile.userId
                    let name = profile.name
                    self.logUser(email: em, id: id, username: name)
                    // Our idToken is still valid...
                    // We store the fetched user profile
                    self.keychain.setData(NSKeyedArchiver.archivedData(withRootObject: profile), forKey: "profile")
                    // ✅ At this point, you can log the user into your app,
                    Auth0.loginComplete = true
                    
                    if Auth0.calledBySubclass == false {
                        
                        self.continueToApp(controller: self.controller, vc: self)
                    }
                    
                    
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
        
        
        // each of the below mentioned fields are optional
        // if set, these populate demographic information in the Dashboard
  
    }
    
}

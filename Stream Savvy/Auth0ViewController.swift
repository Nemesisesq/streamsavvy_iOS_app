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
import AWSCognito


@objc class Auth0ViewController: UIViewController, Auth0Protocol{
    
    
    public var dataset: AWSCognitoDataset!
    public var colorField: UITextField!

    
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
        
        
               
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.usEast1,
                                                                identityPoolId:"us-east-1:2ae1ef8e-a34b-4982-a3b0-3d11b5481819")
        
        let configuration = AWSServiceConfiguration(region:.usEast1, credentialsProvider:credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        Auth0.calledBySubclass = false
        
        // Do any additional setup after loading the view.
        
        // Initialized from the pool ID and region in Info.plist, and
        // implicitly logs in an anonymous user.
        dataset = AWSCognito.default().openOrCreateDataset("userProfile")
        
//        colorField = UITextField(frame: CGRect(x:40, y:70, 280, 30))
//        colorField.returnKeyType = .done
//        colorField.placeholder = "Favorite color"
//        colorField.addTarget(self, action: #selector(self.syncColor(_:)), for: .PrimaryActionTriggered)
//        view.addSubview(colorField)
//        
//        colorField.becomeFirstResponder()
       

    }
    
    func synchronizeDataset() {
        dataset.synchronize().continue({ task in
            if let error = task.error {
                NSLog("Error in sync: %@", error.localizedDescription)
                return nil
            }
            
            if task.isCompleted {
                NSLog("Sync successful")
                DispatchQueue.main.async() { [weak self] in
                    
                    
                    if(self?.dataset.string(forKey: "set_up") != "seen") && Auth0.loggedIn {
                        let vc = UIStoryboard(name: "SetUp", bundle: nil).instantiateViewController(withIdentifier:"SetUpNavgaitionController")
                        
                        self?.present(vc, animated: true, completion: nil)
                    }
                }
            }
            
            return nil
        })
    }

    
        
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        synchronizeDataset()

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
                    
                    let p = UserProfile(profile: profile)
                    
          
                    
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

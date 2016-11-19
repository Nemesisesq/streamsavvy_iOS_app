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
import Crashlytics


class ProfileTableViewController: UITableViewController, Auth0Protocol {
    
    var avc: UIActivityViewController!
    
    var keychain = Auth0.keychain
    
    var client = Auth0.client
    
    var controller = Auth0.controller
    
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var verifiedLabel: UILabel!
    
    @IBOutlet var nicknameTextField: UITextField!
    
    @IBOutlet var profileImageView: UIImageView! {
        didSet{
            profileImageView.layer.cornerRadius = 50
            profileImageView.layer.masksToBounds = true
        }
    }
    
    @IBAction func crashButtonTapped(sender: AnyObject) {
        Crashlytics.sharedInstance().crash()
    }

    
    @IBAction func shareApplication(_ sender:AnyObject){
        avc = UIActivityViewController(activityItems: ["I Stream Savvy. Do you? Check out the best TV guide for streaming https://appsto.re/us/oO8Beb.i"], applicationActivities: nil)
        
        self.present(avc, animated: true, completion: nil)  
    }
    
    @IBAction func feedback(_ sender: AnyObject){
        if let tbc = self.tabBarController as? SSTabBarController{
            tbc.showRating()
        }
    }
    
    
    @IBAction func logout(_ sender: AnyObject) {
        keychain.clearAll()
        Auth0.resetAll()
        A0Lock.shared().present(controller, from: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        controller.onUserDismissBlock = {
            self.continueToApp(controller: self.controller, vc: self)
            Auth0.userDismissed = true
            return
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth0.calledBySubclass = true
        
        // Do any additional setup after loading the view.
        
        do {
            
            let idToken = try checkForIdToken(keychain: Auth0.keychain, controller: Auth0.controller, vc: self)
            
            _ = fetchUserProfile(client: client, idToken: idToken, keychain: keychain, controller: controller)
                .then { result -> Void in
                    
                    if let profile = result as? A0UserProfile {
                        self.emailTextField.text = profile.email
                        self.nicknameTextField.text = profile.nickname
                        self.profileImageView.sd_setImage(with: profile.picture)
                        
                        if let x = profile.extraInfo["email_verified"]   {
                            if( x as! Bool) {
                                self.verifiedLabel.text = "verified"
                            } else {
                                self.verifiedLabel.text = "unverified"
                            }
                        }
                        
                    }
            }
        } catch {
            
        }
        
        
        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x:20, y:50, width:100, height:30)
        button.setTitle("Crash", for: .normal)
        button.backgroundColor = Constants.streamSavvyRed()
        button.addTarget(self, action: #selector(ProfileTableViewController.crashButtonTapped), for: UIControlEvents.touchUpInside)
        view.addSubview(button)

        
        
        
        
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

//
//  Auth0ViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/20/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit
import Lock

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
        
        override func viewDidAppear(_ animated: Bool) {
                let controller = A0Lock.shared().newLockViewController()
                
                controller?.closable = true
                controller?.onAuthenticationBlock = { profile, token in
                        // Do something with token  profile. e.g.: save them.
                        // Lock will not save these objects for you.
                        
                        UserPrefs.setToken(token?.accessToken)
                        UserPrefs.setEmail(profile?.email)
                        
                        
                        
                        
                        // Don't forget to dismiss the Lock controller
                        controller?.dismiss(animated: true, completion: nil)
                        
                        if let mc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") {
                                self.present(mc, animated: true, completion: nil)
                        }
                        
                        self.loginComplete = true
                        
                }
                
                
                if loginComplete != true {
                     A0Lock.shared().present(controller, from: self)
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

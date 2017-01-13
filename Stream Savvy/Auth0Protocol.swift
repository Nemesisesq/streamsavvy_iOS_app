//
//  Auth0.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/27/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import Foundation
import Lock
import SimpleKeychain
import PromiseKit


@objc class Auth0: NSObject {
    
    
    static var calledBySubclass: Bool = false
    
    static var loggedIn: Bool = false
    
    static var loginComplete: Bool? = false
    
    static var userDismissed: Bool = false
    
    static let keychain = A0SimpleKeychain(service: "Auth0")
    
    static let client = A0Lock.shared().apiClient()
    
    static var controller: A0LockViewController {
        let c = A0Lock.shared().newLockViewController()
        
        let theme = A0Theme()
        
        theme.register(Constants.streamSavvyRed(), forKey: A0ThemePrimaryButtonNormalColor)
        theme.register(UIColor.white, forKey: A0ThemePrimaryButtonTextColor)
        theme.register(UIColor.black, forKey: A0ThemeScreenBackgroundColor)
        theme.registerImage(withName: "marks_streamsavvy_mark_large", bundle: Bundle.main, forKey: A0ThemeIconImageName)
        theme.register(UIColor.clear, forKey: A0ThemeIconBackgroundColor)
        theme.register(UIColor.white, forKey: A0ThemeDescriptionTextColor)
        theme.register(UIColor.white, forKey: A0ThemeSeparatorTextColor)
        theme.register(UIColor.white, forKey: A0ThemeTitleTextColor)
        theme.register(UIColor.white, forKey: A0ThemeSecondaryButtonTextColor)
        theme.register(UIColor.white, forKey: A0ThemeTextFieldTextColor)
        theme.register(UIColor.white, forKey: A0ThemeTextFieldIconColor)
        theme.register(UIColor.white, forKey: A0ThemeTextFieldPlaceholderTextColor)
        theme.register(Constants.streamSavvyRed(), forKey:A0ThemeCloseButtonTintColor)
        
        
        
        A0Theme.sharedInstance().register(theme)
        c?.closable = true
        
        c?.onAuthenticationBlock = { profile, token in
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
            keychain.setData(NSKeyedArchiver.archivedData(withRootObject: profile!), forKey: "profile")
            
            
            // Don't forget to dismiss the Lock controller
            c?.dismiss(animated: true, completion: nil)
            
            
            loggedIn = true
        }
        
        return c!
        
    }
    
    static func resetAll() {
        Auth0.loggedIn = false
        Auth0.userDismissed  = false
        Auth0.loginComplete = false
    }
    
}


protocol Auth0Protocol: class {
    
    func fetchUserProfile(client: A0APIClient, idToken: String, keychain: A0SimpleKeychain, controller: A0LockViewController) -> Promise<Any>
    
    func fetchNewIdToken(controler: A0LockViewController, client: A0APIClient, refreshToken: String, keychain: A0SimpleKeychain) -> Promise<Any>
    
    func continueToApp(controller: A0LockViewController, vc: UIViewController) -> Void
    
    func checkForIdToken(keychain: A0SimpleKeychain, controller: A0LockViewController, vc: UIViewController) throws -> String
}

extension Auth0Protocol {
    
    func checkForIdToken(keychain: A0SimpleKeychain, controller: A0LockViewController, vc: UIViewController) throws -> String {
        guard let idToken = keychain.string(forKey: "id_token") else {
            // idToken doesn't exist, user has to enter his credentials to log in
            // Present A0Lock Login
            
            if Auth0.userDismissed == false {
                A0Lock.shared().present(controller, from: vc)
            }
            throw MyError.Null
        }
        
        return idToken
        
    }
    
    
    func continueToApp(controller: A0LockViewController, vc: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
        if let mc = vc.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") {
            vc.present(mc, animated: true, completion: nil)
        }
        
    }
    
    func fetchNewIdToken(controler: A0LockViewController, client: A0APIClient, refreshToken: String, keychain: A0SimpleKeychain) -> Promise<Any> {
        return Promise {fulfill, reject in
            client.fetchNewIdToken(withRefreshToken: refreshToken,
                                   parameters: nil,
                                   success: {newToken in
                                    Auth0.loggedIn = true
                                    
                                    
                                    fulfill(newToken)
                                    
                                    // ✅ At this point, you can log the user into your app, by navigating to the corresponding screen
            },
                                   failure: { error in
                                    
                                    Auth0.loggedIn = false
                                    
                                    // refreshToken is no longer valid (e.g. it has been revoked)
                                    // Cleaning stored values since they are no longer valid
                                    
                                    
                                    reject(error)
                                    
                                    // ⛔️ At this point, you should ask the user to enter his credentials again!
                                    
            })
        }
        
    }
    
    func fetchUserProfile(client: A0APIClient, idToken: String, keychain: A0SimpleKeychain, controller: A0LockViewController) -> Promise<Any>{
        return Promise {fulfill, reject in
            client.fetchUserProfile(withIdToken: idToken,
                                    success: { profile in
                                        fulfill(profile)
                                        
                                        if profile.email != nil {
                                            
                                        
                                        Pushbots.sharedInstance().setAlias(profile.email)
                                        }
                                        Auth0.loggedIn = true
            },
                                    failure: { error in
                                        
                                        Auth0.loggedIn = false
                                        
                                        reject(error)
            })
        }
    }
}

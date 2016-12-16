//
//  UserProfile.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 11/25/16.
//  Copyright © 2016 StreamSavvy. All rights reserved.
//

import UIKit
import Lock
import Crashlytics


class UserProfile: User {
    
    
    var name: String?
    var identity: String?
    var phoneNumber: Int32?
    var gender: String?
    var employed: String?
    
    var education: String?
    
    var married:String?
    var dob: Date?
    var age : Int?
    var photo : URL?
    
    var msgEmail: Bool?
    var msgPush: Bool?
    var msgSMS: Bool?
    
    override init(){
        super.init()
        
    }
    
    init(user: User){
        super.init()
        name = "\(user.firstname) \(user.lastname)"
        self.email = user.email
    }
    
    init(profile: A0UserProfile){
        super.init()
        name = profile.name
        self.email = profile.email
        identity = profile.userId
        photo = profile.picture
        
    }
    
//    func setCleverTapProfile(){
//        
//        let p = self
//        let profile: Dictionary<String, Any> = [
//            "Name": p.name ?? "blank",                // String
//            "Identity": p.identity!,                   // String or number
//            "Email": p.email ?? "blank",              // Email address of the user
//            "Phone": "",                    // Phone (without the country code)
//            "Gender": p.gender as Any,                          // Can be either M or F
//            "Employed": p.employed as Any,                        // Can be either Y or N
//            "Education": p.education as Any,                // Can be either School, College or Graduate
//            "Married": p.married as Any,                         // Can be either Y or N
//            "DOB": p.dob as Any,                        // Date of Birth. An NSDate object
//            "Age": p.age as Any,                              // Not required if DOB is set
//            "Photo": p.photo!,   // URL to the Image
//            
//            // optional fields. controls whether the user will be sent email, push etc.
//            "MSG-email": p.msgEmail as Any,                     // Disable email notifications
//            //                        "MSG-push": true as AnyObject,                       // Enable push notifications
//            "MSG-sms": true as Any                       // Disable SMS notifications
//        ]
//        
//        
//        CleverTap.sharedInstance()?.profilePush(profile)
//    
//        CleverTap.sharedInstance()?.recordEvent("profile set")
//        
//    }
    func logUserForCrashlytics() {
        // TODO: Use the current user's information
        // You can call any combination of these three methods
        Crashlytics.sharedInstance().setUserEmail(email)
        Crashlytics.sharedInstance().setUserIdentifier(identity)
//        Crashlytics.sharedInstance().setUserName(us)
    }
}

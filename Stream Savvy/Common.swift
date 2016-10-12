//
//  Common.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/3/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import Foundation


typealias JSONStandardDict  = [String: AnyObject]

let application = UIApplication.shared

struct Common {
        
        
        static func getReadableJsonDict(data : Data ) -> JSONStandardDict {
                do {
                        print("@")
                        
                        let  readableJSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! JSONStandardDict
                        print("@%")
                        return readableJSON
                }
                catch {
                        
                }
                print("@%%")
                return ["hello" : "world" as AnyObject]
        }
        
        
        static func getRandomColor() -> UIColor{
                let randomRed:CGFloat = CGFloat(drand48())
                let randomGreen:CGFloat = CGFloat(drand48())
                let randomBlue:CGFloat = CGFloat(drand48())
                return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        }
        
        
      static func openDeepLink(link:String) {
                
                //        let link = getDeepLink()
        
                if self.schemeAvailable(deepLink: link) {
                        application.openURL(URL.init(string: link)!)
                        
                } else {
                        
                        Constants.showAlert("We're sorry", withMessage: "You Don't have this app")
                }
                
                
                
        }
        
        
        static func schemeAvailable(deepLink: String) -> Bool {
                return application.canOpenURL(URL.init(string: deepLink)!)
        }
        
}

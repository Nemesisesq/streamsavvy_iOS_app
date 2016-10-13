//
//  Common.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/3/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import Foundation
import JavaScriptCore


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
                
                application.openURL(URL.init(string: link)!)
                
                
        }
        
        
        static func schemeAvailable(deepLink: String) -> Bool {
                return application.canOpenURL(URL.init(string: deepLink)!)
        }

        
        
        static func getJSContext() -> JSContext {
                let fileURL = Bundle.main.url(forResource: "lodash", withExtension: "js")
                let lodash = try! String(contentsOf: fileURL!, encoding:String.Encoding.utf8)
                
                let context = JSContext()
                
                _ = context?.evaluateScript(lodash)
                
                return context!
                
        }
        
}

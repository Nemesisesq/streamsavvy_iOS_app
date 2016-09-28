//
//  NSObjectExtensions.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 9/27/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import Foundation

protocol PropertyNames {
    func propertyNames() -> [String]
}


extension NSObject {
    // Creates an object from a dictionary
    class func fromJson(jsonInfo: NSDictionary) -> Self {
        let object = self.init()
        
        (object as NSObject).load(jsonInfo: jsonInfo)
        
        return object
    }
    
    func load(jsonInfo: NSDictionary) {
        for (key, value) in jsonInfo {
            let keyName = key as! String
            
            if (responds(to: NSSelectorFromString(keyName))) {
                setValue(value, forKey: keyName)
            }
        }
    }
    
    func asJson() -> NSDictionary {
        let json = NSMutableDictionary()
        
        for name in propertyNames() {
            if let value: AnyObject = value(forKey: name) as AnyObject? {
                json[name] = value
            }
        }
        
        
        return json
    }
    
    func propertyNames() -> [String] {
        return Mirror(reflecting: self).children.flatMap { $0.label }
    }
}

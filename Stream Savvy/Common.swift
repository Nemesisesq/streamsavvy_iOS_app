//
//  Common.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/3/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import Foundation


typealias JSONStandardDict  = [String: AnyObject]

func getReadableJsonDict(data : Data ) -> JSONStandardDict {
    do {
    
    
    let  readableJSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! JSONStandardDict
        return readableJSON 
    }
    catch {
        
    }
    
    return ["hello" : "world" as AnyObject]
}

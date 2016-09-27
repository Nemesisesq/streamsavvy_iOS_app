//
//  Favorites.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 9/26/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
//import SwiftyJSON


class Favorites: NSObject {
    
    var contentList = [Content]()
    
    public func fetchFavorites() -> Promise<Any> {
        let url = "http://localhost:8080/favorites/test"
        
        return Promise { fullfil, reject in
            Alamofire.request(url)
                .responseJSON {response in
                    
                    self.contentList = [Content.parseDict(dict: response.data! as AnyObject)]
                    
                    switch response.result {
                    case .success(let dict):
                        fullfil(dict)
                        
                    case .failure(let error):
                        reject(error)
                    }
            }
            
            
        }
    }
    
   class func addContentToFavorites(content: Content) -> Void {
        
        let url = "http://localhost:8080/favorites/add/test"
        let theJson : Data
        
        do{
            theJson = try JSONSerialization.data(withJSONObject: content, options: .prettyPrinted)
            
        }
        catch {
            print(error)
        }
//        Alamofire.request(.POST,
//                          url,
//                          parameters: theJson,
//                          JSONEncoding.default)
        
    }
    
}

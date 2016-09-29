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
        let url = "http://edr-go-staging.herokuapp.com/favorites/test"
        
        return Promise { fullfil, reject in
            Alamofire.request(url)
                .responseJSON {response in
                    
                    self.contentList = Content.parseList(JSONData: (response.data! as Data))
                    
                    switch response.result {
                    case .success(let dict):
                        fullfil(dict)
                        
                    case .failure(let error):
                        reject(error)
                    }
            }
        }
    }
    
    class func addContentToFavorites(content: Content) -> Promise<Void> {
        
        let url = "http://edr-go-staging.herokuapp.com/favorites/add/test"
        let theJson = content.asJson()
        
        return Promise { fulfill, reject in
            Alamofire.request(url, method: .post, parameters: theJson as? Parameters,  encoding: JSONEncoding.default)
                .responseJSON { response in
                    
                    switch response.result {
                    case .success:
                        fulfill()
                        
                    case .failure(let error):
                        reject(error)
                    }
            }
        }
        
    }
}

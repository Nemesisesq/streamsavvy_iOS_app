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
import Dollar
import SimpleKeychain
import Lock


//import SwiftyJSON


let host = "www.streamsavvy.cloud"
//var host = "localhost:8080"


class Favorites: NSObject {
    
    var favs = [TableFav]()
    
    var contentList = [Content]() {
        didSet{
            let titles = contentList.map {
                (c) -> String in
                
                return c.title
            }
            Pushbots.sharedInstance().update(["tags":titles])
        }
    }
    
    var profile: A0UserProfile!
    
    var keychain = A0SimpleKeychain(service: "Auth0")
    
    
    
    public func fetchFavorites() -> Promise<Any> {
         let q = GraphQLAPI.getFavoritesQuery().create()
        
        _ = GraphQLAPI.fetchGraphQLQuery(q: q)
            .then { the_json -> Void in
                
                if let t = the_json["data"] as? [String: [[String: Any]]] {
                    
                    for i in t["favorites"]! {
                        let x = TableFav.init(json: i as [String:Any])
                        self.favs.append(x)
                    }
                    
                
                    
                    
                }
                
                
        }

        let url = "http://\(host)/favorites"
        
        
        
        
        return Promise { fullfil, reject in
            
            
            
            if  let p = keychain.data(forKey: "profile") {
                
                profile = NSKeyedUnarchiver.unarchiveObject(with:p) as! A0UserProfile
            }
            
            
            let params: Parameters = [
                "id_token": keychain.string(forKey: "id_token")!,
                
                "email" : profile.email ?? "no_email",
                "name"  : profile.name,
                ]
            
            let authHeader: HTTPHeaders = ["Id-Token" :keychain.string(forKey: "id_token")!,
                                           "Accept": "application/json",
                                           "User-Id" : profile.userId]
            
            
            Alamofire.request(url, parameters: params, headers: authHeader)
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
    
    public func removeContentFromFavorites(content: Content) -> Promise<Void> {
        
        if  let p = keychain.data(forKey: "profile") {
            
            profile = NSKeyedUnarchiver.unarchiveObject(with:p) as! A0UserProfile
        }
        
        
        let mutation = GraphQLAPI.toggleShowToFavorites(show: content, favorite: false).create()
        
        _ = GraphQLAPI.fetchGraphQLQuery(q: mutation)
            .then { the_json -> Void in
                
                if let t = the_json["data"] as? [String: [String: Any]]{
                    
                    let state = t["toggleShow"]?["status"] as! Bool
                    
                }
                
        }

        
        
        let url = "http://\(host)/favorites/remove"
        let theJson = content.asJson()
        let authHeader: HTTPHeaders = ["Id-Token" :keychain.string(forKey: "id_token")!,
                                       "Accept": "application/json",
                                       "User-Id" : profile.userId]
        
        
        Pushbots.sharedInstance().update(["tags_remove": content.title ])
        return Promise { fulfill, reject in
            Alamofire.request(url, method: .delete, parameters: theJson as? Parameters,  encoding: JSONEncoding.default, headers: authHeader)
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
    public func addContentToFavorites(content: Content) -> Promise<Void> {
        if  let p = keychain.data(forKey: "profile") {
            
            profile = NSKeyedUnarchiver.unarchiveObject(with:p) as! A0UserProfile
        }
        
        let mutation = GraphQLAPI.toggleShowToFavorites(show: content, favorite: true).create()
        
        _ = GraphQLAPI.fetchGraphQLQuery(q: mutation)
            .then { the_json -> Void in
                
                if let t = the_json["data"] as? [String: [String: Any]]{
                    
                    let state = t["toggleShow"]?["status"] as! Bool
                                        
                }
                
        }

        
        
        let url = "http://\(host)/favorites/add"
        let theJson = content.asJson()
        let authHeader: HTTPHeaders = ["Id-Token" :keychain.string(forKey: "id_token")!,
                                       "Accept": "application/json",
                                       "User-Id" : profile.userId]
        
        Pushbots.sharedInstance().update(["tags_add": content.title ])
        return Promise { fulfill, reject in
            Alamofire.request(url, method: .post, parameters: theJson as? Parameters,  encoding: JSONEncoding.default, headers: authHeader)
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

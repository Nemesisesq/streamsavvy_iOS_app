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
    
    static let sharedInstance = Favorites()
    
    private override init() {
        super.init()
        getFavsFromGraphQL()
    }
    
    var _favs = [TableFav]()
    
    var favs: [TableFav]! {
        get {
            if self._favs.count == 0 {
                getFavsFromGraphQL()
            }
            
            return self._favs
        }
        
        set(x) {
            self._favs = x
        }
    }
    
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
    
    
    func getFavsFromGraphQL(){
        let q = GraphQLAPI.getFavoritesQuery().create()
        
        _ = GraphQLAPI.fetchGraphQLQuery(q: q)
            .then { the_json -> Void in
                
                if let t = the_json["data"] as? [String: [[String: Any]]] {
                    
                    var temp = [TableFav]()
                    for i in t["favorites"]! {
                        let x = TableFav.init(json: i as [String:Any])
                        temp.append(x)
                    }
                    
                    self._favs = temp
                }
        }
        
    }
    
    public func fetchFavorites() -> Promise<Void> {
        
        let q = GraphQLAPI.getFavoritesQuery().create()
        
        return GraphQLAPI.fetchGraphQLQuery(q: q)
            .then { the_json -> Void in
                
                if let t = the_json["data"] as? [String: [[String: Any]]] {
                    
                    var temp = [TableFav]()
                    for i in t["favorites"]! {
                        let x = TableFav.init(json: i as [String:Any])
                        temp.append(x)
                    }
                    
                    self._favs = temp
                }
        }
        
    }
    
    public func removeContentFromFavorites(content: Content) -> Promise<Void> {
        
        if  let p = keychain.data(forKey: "profile") {
            
            profile = NSKeyedUnarchiver.unarchiveObject(with:p) as! A0UserProfile
        }
        
        
        let mutation = GraphQLAPI.toggleShowToFavorites(show: content, favorite: false).create()
        
        return GraphQLAPI.fetchGraphQLQuery(q: mutation)
            .then { the_json -> Void in
                Pushbots.sharedInstance().update(["tags_remove": content.title ])
                
                if let t = the_json["data"] as? [String: [[String: Any]]] {
                    
                    var temp = [TableFav]()
                    for i in t["toggleShow"]! {
                        let x = TableFav.init(json: i as [String:Any])
                        temp.append(x)
                    }
                    
                    self._favs = temp
                }
        }
    }
    
    public func addContentToFavorites(content: Content) -> Promise<Void> {
        if  let p = keychain.data(forKey: "profile") {
            
            profile = NSKeyedUnarchiver.unarchiveObject(with:p) as! A0UserProfile
        }
        
        let mutation = GraphQLAPI.toggleShowToFavorites(show: content, favorite: true).create()
        
        return GraphQLAPI.fetchGraphQLQuery(q: mutation)
            .then { the_json -> Void in
                Pushbots.sharedInstance().update(["tags_add": content.title ])
                if let t = the_json["data"] as? [String: [[String: Any]]] {
                    
                    var temp = [TableFav]()
                    for i in t["toggleShow"]! {
                        let x = TableFav.init(json: i as [String:Any])
                        temp.append(x)
                    }
                    
                    self._favs = temp
                }
        }
    }
}

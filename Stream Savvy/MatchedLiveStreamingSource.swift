//
//  MatchedLiveStreamingSources.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 11/8/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import Foundation
import Gloss

class LiveLinkTemplate: Decodable {
    var appName: String!
    var serviceName: String!
    var template: String!
    
    var versions: String!
    
    public required init?(json: JSON){
        appName = "app_name" <~~ json
        serviceName = "service_name" <~~ json
        template = "template" <~~ json
        versions = "versions" <~~ json
    }
}

class Price: Decodable {
    var service: String!
    var unitCost: String!
    
    public required init?(json: JSON) {
        service = "service" <~~ json
        unitCost = "unit_cost" <~~ json
    }
}

class Links: Decodable {
    var app_name: String!
    var app_store: String!
    var deeplink: String!
    var signup: String!
    
    public required init?(json: JSON) {
        app_name = "app_name" <~~ json
        app_store = "app_store" <~~ json
        deeplink = "deeplink"   <~~ json
        signup = "signup"  <~~ json
    }
}

class MatchedLiveStreamingSourceSerivce : Decodable, Hashable {
    
    static var nextUid:Int = 1
    static func generateUid() -> Int {
        nextUid += 1
        return nextUid
    }
    
    
    static func ==(lhs: MatchedLiveStreamingSourceSerivce, rhs: MatchedLiveStreamingSourceSerivce) -> Bool {
        return lhs.uid == rhs.uid
    }
    
    var app: String!
    var appIdentifier: String!
    var service: String!
    var template: LiveLinkTemplate!
    var price: Price!
    var links: Links!
    var uid: Int!
    
    var hashValue: Int {
        return uid
    }
    
    
    public required init?(json: JSON){
        uid = MatchedLiveStreamingSourceSerivce.generateUid()
        app = "app" <~~ json
        appIdentifier = "app_identifier" <~~ json
        service = "service" <~~ json
        template = "template" <~~ json
        price = "price" <~~ json
        links = "link" <~~ json
    }
    
}

//
//  Sources.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/11/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import Foundation
import Gloss

class Source: Decodable {
        let source: String?
        let display_name: String?
        let id: Int?
        let link: String?
        
        required init?(json: [String:Any]) {
                source = "source" <~~ json
                display_name = "display_name" <~~ json
                id = "id" <~~ json
                link = "link"  <~~ json
        }
}

class IOSSubscriptionSource : Source {
        var app_name: String?
        var app_link: Int?
        var app_required: Int?
        var app_download_link : String?
        
        required init?(json: [String:Any]){
                super.init(json: json)
                app_name = "app_name" <~~ json
                app_link = "app_link" <~~ json
                app_required = "app_required" <~~ json
                app_download_link = "app_downlaod_link" <~~ json
                
                
                
        }
}

class Formats : Decodable {
        let price : String?
        let format: String?
        let type: String?
        
        required init?(json : [String: Any]) {
                price = "price" <~~ json
                format = "format" <~~ json
                type = "type" <~~ json
        }
}

class IOSPurchaseSources : IOSSubscriptionSource{
        var formats: [Formats]?
        
        required init?(json : [String:Any]){
                super.init(json: json)
                formats = "formats" <~~ json
        }
}



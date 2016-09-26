//
//  SearchResults.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 9/19/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit



class SearchResults: NSObject {
    var results = [Content]()
    
    typealias JSONStandard = [[String: AnyObject]]
    
    public func fetchResults(q: String) -> Promise<Any> {
        
        let url = "http://ss-master-staging.herokuapp.com/api/search/?q=\(q)"
        return Promise { fullfill, reject in
            Alamofire.request(url)
                .responseJSON{
                    response in self.parseData(JSONData: response.data!)
                    
                    switch response.result {
                    case .success(let dict):
                        fullfill(dict)
                        
                    case .failure(let error):
                        reject(error)
                        
                    }
            }
        }
    }
    
    
    
    func parseData(JSONData : Data) {
        do {
            let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            // print(readableJSON)
            
            
            for dict in readableJSON {
                let content  = Content()
                //                content.setValuesForKeys(dict)
                content.title = dict["title"] as? String
                content.guidebox_data = dict["guidebox_data"] as? NSMutableDictionary
                content.on_netflix = dict["on_netflix"] as? Bool
                content.channel = dict["channel"] as? NSMutableDictionary
                content.curr_pop_score = dict["curr_pop_score"] as? Float
                content.channels_last_checked  = dict["channels_last_checked"] as? String
                content.modified = dict["modified"] as? String
		
		print("@@@@@@@@@ ")
                print(content.title)
                
                self.results.append(content)
                
                
            }
            print(self.results)
        }
        catch let error {
            print(error)
        }
        
        //        print(self.results)
        
    }
}


class Content: NSObject {
    
    
    var title : String?
    var guidebox_data : NSMutableDictionary?
    var on_netflix : Bool?
    var channel : NSMutableDictionary?
    var curr_pop_score : Float?
    var channels_last_checked : String?
    var modified : String?
    
}

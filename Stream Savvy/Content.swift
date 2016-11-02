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



public class SearchResults: NSObject {
    var results = [Content]()
    
    public func fetchResults(q: String) -> Promise<Any> {
        
        let url = "http://ss-master-staging.herokuapp.com/api/search/?q=\(q)"
        return Promise { fullfill, reject in
            Alamofire.request(url)
                .responseJSON{
                    response in
                    
                    self.results = Content.parseList(JSONData: response.data!)
                    
                    switch response.result {
                    case .success(let dict):
                        fullfill(dict)
                        
                    case .failure(let error):
                        reject(error)
                        
                    }
            }
        }
    }
    
    
    
}


public class Content: NSObject {
    
    
    var title : String!
    var guidebox_data : NSDictionary!
    var guidebox_id : Int!
    var on_netflix : Bool?
    var channel : NSMutableDictionary!
    var curr_pop_score : Float!
    var channels_last_checked : String!
    var modified : String!
    var image_link : String!

    override init() {
        
    }
    
    init(withPopularShow show: PopularShow){
        self.title = show.title
        self.guidebox_id = show.guidebox_id
        let  data = show.raw as NSDictionary as! [String: Any]
        self.guidebox_data = data["guidebox_data"] as! NSDictionary?
	
        self.image_link = show.image_link
        print("$$$ ~ \(show.image_link)")
    }
    
    class func getNextPage(url:String) -> Promise<[String:[AnyHashable:Any]]> {
        return Promise {fulfill, reject in
        Alamofire.request(url)
            .responseJSON { response in
                
               
            let the_json = Common.getReadableJsonDict(data: response.data!)
                switch response.result{
                case .success(let the_json):
                    fulfill(the_json as! [String : [AnyHashable : Any]])
                case .failure(let error):
                    reject(error)
                }
                
                
            }
            
        }
    }
    
    class func parseList(JSONData : Data) -> [Content] {
        
        typealias JSONStandard = [[String: AnyObject]]
        var contentList = [Content]()
        
        do {
            
            
            
            let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            // print(readableJSON)
            
            
            for dict in readableJSON {
                let content = parseDetail(dict: dict as AnyObject)
//                print("@@@@@@@@@")
//                print(content.title)
                
                contentList.append(content)
                
                
            }
        }
        catch let error {
            print(error)
        }
        
        //        print(self.results)
        
        return contentList
        
    }
    
    class func parseDetail(dict: AnyObject) -> Content {
        let content  = Content()
        //                content.setValuesForKeys(dict)
//	print("###\n\n###")
//	print(dict)
//	print("@@@\n\n@@@")
        content.title = dict["title"] as? String
        content.guidebox_id = (dict["guidebox_data"] as? NSMutableDictionary)?.object(forKey: "id") as! Int!
        content.guidebox_data = dict["guidebox_data"] as? NSMutableDictionary
        content.on_netflix = dict["on_netflix"] as? Bool
        content.channel = dict["channel"] as? NSMutableDictionary
        content.curr_pop_score = dict["curr_pop_score"] as? Float
        content.channels_last_checked  = dict["channels_last_checked"] as? String
        content.modified = dict["modified"] as? String
	content.image_link = (dict["guidebox_data"] as? NSMutableDictionary)?.object(forKey: "artwork_608x342") as? String
        return content
	
    }
    
    
}



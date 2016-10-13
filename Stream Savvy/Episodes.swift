//
//  Episode.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/2/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit
import PromiseKit
import Alamofire
import Gloss


public class Episode: Decodable {
        let id: Int?
        let tvdb: Int?
        let contentType: String?
        let imdbId: Int?
        let seasonNumber: Int?
        let episodeNumber: Int?
        let showId: Int?
        let themoviedb: Int?
        let firstAired: String?
        let title: String?
        let originalTitle: String?
        let overview: String?
        let duration: Int?
        let productionCode: String?
        let thumbnail208X117: String?
        let thumbnail304X171: String?
        let thumbnail400X225: String?
        let thumbnail608X342: String?
        let subscription_ios_sources: [IOSSubscriptionSource]?
        let purchase_ios_sources: [IOSPurchaseSource]?
	
        var _guidebox_id: String?
        var episode_list: NSDictionary?


	
	public required init?(json: [String:Any]){
		print("%%%%%")
		print(json["subscription_ios_sources"])
                id = "id" <~~ json
                tvdb = "tvdb"  <~~ json
                contentType = "content_type"  <~~ json
                imdbId = "imdb_id"  <~~ json
                seasonNumber = "season_number" <~~ json
                episodeNumber = "episode_number"  <~~ json
                showId = "show_id" <~~ json
                themoviedb  = "themoviedb" <~~ json
                firstAired = "first_aired" <~~ json
                title = "title" <~~ json
                originalTitle = "original_title" <~~ json
                overview = "overview" <~~ json
                duration = "duration" <~~ json
                productionCode = "production_code" <~~ json
                thumbnail208X117 = "thumbnail_208x117" <~~ json
                thumbnail304X171 = "thumbnail_304x171" <~~ json
                thumbnail400X225 = "thumbnail_400x225" <~~ json
                thumbnail608X342 = "thumbnail_608x342" <~~ json
                subscription_ios_sources = "subscription_ios_sources" <~~ json
                purchase_ios_sources  = "purchase_ios_sources" <~~ json
//                deep_links = ["http://www.google.com", "http://www.youtube.com"]
                
        }
        
        
        
        class func getEpisodeList(guidebox_id: String) -> Promise<[Episode]> {
                
//                let url = "http://localhost:8080/episodes"
                        let url = "https://edr-go-staging.herokuapp.com/episodes"
                
                let parameters = ["guidebox_id": guidebox_id]
                
                return Promise {fullfill, reject in
                        Alamofire.request(url, parameters:parameters)
                                .responseJSON { response -> Void in
                                        var epiList = [Episode]()
                                        
                                        let the_json = Common.getReadableJsonDict(data: response.data!)
                                        
                                        let result = the_json["results"] as? NSArray
                                        result?.forEach(){ epi in
						epiList.append(Episode(json: epi as! [String : Any])!)
                                                
                                        }
                                        
                                        let ep = Episode(json: ["hello": "World"])
                                        
                                        
                                        switch response.result {
                                        case .success:
                                                fullfill(epiList)
                                                
                                        case .failure(let error):
                                                reject(error)
                                        }
                        }
                }
        }
}

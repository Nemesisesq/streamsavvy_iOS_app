//
//  API.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 12/31/16.
//  Copyright © 2016 StreamSavvy. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import Lock
import SimpleKeychain


class GraphQLAPI : NSObject   {
    
    static var email: String!
    
    static var profile: A0UserProfile! {
        didSet {
            
            email = profile.email ?? ""
        }
    }
    
    static var keychain = A0SimpleKeychain(service: "Auth0")
    
    static func toggleTeamToFavorites(team: Team, fav: Bool) -> Mutation {
        
        if  let p = keychain.data(forKey: "profile") {
            
            profile = NSKeyedUnarchiver.unarchiveObject(with:p) as! A0UserProfile
        }
        
        let mutatingRequest = Request(
            name: "toggleTeam",
            arguments: [
                Argument(key: "favorite", value: fav),
                Argument(key: "team_brand_id", value: team.teamBrandId),
                Argument(key: "userId", value: profile.userId),
                Argument(key: "email", value: email ),
                
                ],
            fields :[
                "name",
                ]
        )
        
        
        let mutation = Mutation(
            withAlias: "toggleShowToFavorites",
            mutatingRequest: mutatingRequest
        )
        
        return mutation
        
    }
    
    
    
    
    static func toggleShowToFavorites(show: Content, favorite: Bool) -> Mutation {
        
        if  let p = keychain.data(forKey: "profile") {
            
            profile = NSKeyedUnarchiver.unarchiveObject(with:p) as! A0UserProfile
        }
        
        
        
        let mutatingRequest = Request(
            name: "toggleShow",
            arguments: [
                Argument(key: "favorite", value: favorite),
                Argument(key: "guidebox_id", value: show.guidebox_id),
                Argument(key: "userId", value: profile.userId),
                Argument(key: "email", value: email),
                
                ],
            fields :[
                "name",
                ]
        )
        
        
        let mutation = Mutation(
            withAlias: "toggleShowToFavorites",
            mutatingRequest: mutatingRequest
        )
        
        return mutation
        
    }
    
    static func toggleSport(sport: Sport, fav: Bool) -> Mutation {
        
        if  let p = keychain.data(forKey: "profile") {
            
            profile = NSKeyedUnarchiver.unarchiveObject(with:p) as! A0UserProfile
        }
        
        
        
        let mutatingRequest = Request(
            name: "toggleSport",
            arguments: [
                Argument(key: "favorite", value: fav),
                Argument(key: "sportsId", value: Int(sport.sportsId)!),
                Argument(key: "userId", value: profile.userId),
                
                Argument(key: "email", value: email),
                ],
            fields :[
                "name"
            ]
        )
        
        
        let mutation = Mutation(
            withAlias: "addSportsToFavorites",
            mutatingRequest: mutatingRequest
        )
        
        return mutation
    }
    
    
    static var sportQuery: Query =  Query( request: Request (
        withAlias: "sports", //this is an alias that I can uses to differentiate two similar queries.
        name: "sports", //this is the name of the node that I am querying
        fields: [ //these are the fields that I ask for in my response.
            "sportsId",
            "sportsName"
            
        ]
        )
        
    )
    
    
    static func getFavoritesQuery() -> Query? {
        if  let p = keychain.data(forKey: "profile") {
            
            profile = NSKeyedUnarchiver.unarchiveObject(with:p) as! A0UserProfile
            
            
            let teamsQuery: Query = Query(request: Request (
                withAlias:"favorites",
                name: "favorites",
                arguments: [
                    Argument(key: "user_id", value:profile.userId)
                ],
                fields:[
                    "name",
                    ]
            ))
            
            return teamsQuery
        }
        
        return nil
    }
    
    
    
    static func teamsForOrgQuery(id: String) -> Query{
        let teamsQuery: Query = Query(request: Request (
            withAlias:"teams",
            name: "teams",
            arguments: [
                Argument(key: "orgId", value:id)
            ],
            fields:[
                "name",
                "nickname",
                "propername",
                "img",
                "team_brand_id"
            ]
        ))
        
        return teamsQuery
    }
    
    
    static func leaguesForSportQuery(id: String) -> Query{
        let teamsQuery: Query = Query(request: Request (
            name: "orgs",
            arguments: [
                Argument(key: "sportId", value:id)
            ],
            fields:[
                "organization",
                "gracenote_organization_id",
                "img"
                
            ]
        ))
        
        return teamsQuery
    }
    
    
    static func teamsForSportQuery(id: String) -> Query{
        let teamsQuery: Query = Query(request: Request (
            withAlias:"teams",
            name: "teams",
            arguments: [
                Argument(key: "sportId", value:id)
            ],
            fields:[
                "team_brand_id",
                "name",
                "nickname",
                "propername",
                "img"
            ]
        ))
        
        return teamsQuery
    }
    
    //    encoding: .Custom({
    //    (convertible, params) in
    //    let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
    //
    //    let data = ("myBodyString" as NSString).dataUsingEncoding(NSUTF8StringEncoding)
    //    mutableRequest.HTTPBody = data
    //    return (mutableRequest, nil)
    //    }
    
    static func fetchGraphQLQuery(q: String) -> Promise<JSONStandardDict>{
        let url = "http://www.streamsavvy.cloud/graphql"
        //        let url = "http://localhost:8080/graphql"
        
        
        let dispatch = DispatchQueue.global()
        
        return firstly {_ in
            Alamofire.request(url, method: .post, parameters: ["query":q], encoding: JSONEncoding.default, headers: [:])
                .responseData()
            }
            .then(on: dispatch) { data in
                Common.getReadableJsonDict(data: data )
        }
        
    }
    
}






extension String: ParameterEncoding {
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
}


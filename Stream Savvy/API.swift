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


class GraphQLAPI : NSObject   {
    static var sportQuery: Query =  Query( request: Request (
        withAlias: "sports", //this is an alias that I can uses to differentiate two similar queries.
        name: "sports", //this is the name of the node that I am querying
        fields: [ //these are the fields that I ask for in my response.
            "sportsId",
            "sportsName"
            
        ]
        )
        
    )
    
    //    encoding: .Custom({
    //    (convertible, params) in
    //    let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
    //
    //    let data = ("myBodyString" as NSString).dataUsingEncoding(NSUTF8StringEncoding)
    //    mutableRequest.HTTPBody = data
    //    return (mutableRequest, nil)
    //    }
    
    static func fetchGraphQLQuery(q: String) -> Promise<JSONStandardDict>{
        let url = "http://localhost:8080/graphql"
        
        let q = DispatchQueue.global()
        
        return firstly {_ in
            Alamofire.request(url, method: .post, parameters: ["query":q], encoding: JSONEncoding.default, headers: [:])
                .responseData()
            }
            .then(on: q) { data in
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


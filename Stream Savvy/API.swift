//
//  API.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 12/31/16.
//  Copyright © 2016 StreamSavvy. All rights reserved.
//

import Foundation



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
    
    
}

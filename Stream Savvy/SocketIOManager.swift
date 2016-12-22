//
//  SocketIOManager.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 11/17/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit

class SocketIOManager: NSObject {
    var path: String!
    var ws : WebSocket!
    
    override init() {
        super.init()
        path = "echo"
    }
    
    init(endpoint: String){
        super.init()
        path = endpoint
//        ws = WebSocket("ws://Aizengolangapi-dev.us-east-1.elasticbeanstalk.com/sock/\(path!)")
        ws = WebSocket("ws://localhost:8080/sock/\(path!)")

        //        ws = WebSocket("ws://localhost:8080/\(path!)")
        
    }
    
    
    
    
    func echoTest(){
        var messageNum = 0
        let ws = WebSocket("ws://localhost:8080/\(path!)")
        let send : ()->() = {
            messageNum += 1
            let msg = "\(messageNum): \(NSDate().description)"
            print("send: \(msg)")
            ws.send(msg)
        }
        ws.event.open = {
            print("opened")
            send()
        }
        ws.event.close = { code, reason, clean in
            print("close")
        }
        ws.event.error = { error in
            print("error \(error)")
        }
        ws.event.message = { message in
            if let text = message as? String {
                print("recv: \(text)")
                if messageNum == 10 {
                    ws.close()
                } else {
                    send()
                }
            }
        }
    }
}

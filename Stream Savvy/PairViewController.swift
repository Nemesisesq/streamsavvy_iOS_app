//
//  PairViewController.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 1/14/17.
//  Copyright © 2017 StreamSavvy. All rights reserved.
//

import Foundation

class PairViewController: UIViewController {
    
    var socket: SocketIOManager!
    
    @IBOutlet var pairID: UITextField!
    
    @IBAction func pair(_ sender: Any) {
        
        if pairID.text != nil {
            
            socket.ws.send(pairID.text!)
            
            print("hello world")
            
        }
    }
    
    override func viewDidLoad(){
        socket =  SocketIOManager(endpoint: "pair?id=\(pairID.text)")
        
        socket.ws.event.message = { message in 
            
        }
    }
    
    
}

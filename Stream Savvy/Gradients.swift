//
//  Gradients.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 11/1/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import Foundation


extension Common {
    
    func linearGradentTopToBottom() -> CAGradientLayer{
        let startColor = UIColor.black
        let endColor = UIColor.clear
        
        
        let gradient = CAGradientLayer()
        gradient.colors  = [startColor.cgColor, endColor.cgColor]
        gradient.locations  = [0.0, 0.4]
        
        
        return gradient
        
        
        
    }
    
}

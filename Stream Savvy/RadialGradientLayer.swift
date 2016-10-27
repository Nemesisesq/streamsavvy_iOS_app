//
//  RadialGradientLayer.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/26/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import UIKit

class RadialGradientLayer: CALayer {
        
        override init(){
                
                super.init()
                
                needsDisplayOnBoundsChange = true
        }
        
        init(center:CGPoint,radius:CGFloat,colors:[CGColor]){
                
                self.center = center
                self.radius = radius
                self.colors = colors
                
                super.init()
                
        }
        
        required init(coder aDecoder: NSCoder) {
                
                super.init()
                
        }
        
        var center:CGPoint = CGPoint.init(x: 50, y: 50)
        var radius:CGFloat = 20
        var colors:[CGColor] = [UIColor(red: 251/255, green: 237/255, blue: 33/255, alpha: 1.0).cgColor , UIColor(red: 251/255, green: 179/255, blue: 108/255, alpha: 1.0).cgColor]
        
        override func draw(in ctx: CGContext) {
                
                ctx.saveGState()
                
                var colorSpace = CGColorSpaceCreateDeviceRGB()
                
                var locations:[CGFloat] = [0.0, 1.0]
                
                var gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: [0.0,1.0])
                
                var startPoint = CGPoint.init(x:0, y:self.bounds.height)
                var endPoint = CGPoint.init(x:self.bounds.width, y:self.bounds.height)
                
                ctx.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: radius, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
                
        }
        
}

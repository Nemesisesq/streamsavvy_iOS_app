//
//  UILableExtensions.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 10/21/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import Foundation


extension UILabel {
        
        var substituteFontName : String {
                get { return self.font.fontName }
                set { self.font = UIFont(name: "Avenir Black", size: self.font.pointSize) }
        }
        
}

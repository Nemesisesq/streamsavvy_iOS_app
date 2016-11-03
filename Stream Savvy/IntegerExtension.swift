//
//  IntegerExtension.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 11/3/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import Foundation

extension Int {
    func isPrime() -> Bool {
        if self <= 1 {
            return false
        }
        if self <= 3 {
            return true
        }
        var i = 2
        while i*i <= self {
            if self % i == 0 {
                return false
            }
            i = i + 1
        }
        return true
    }

}

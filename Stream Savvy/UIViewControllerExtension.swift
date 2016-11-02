//
//  UIViewControllerExtension.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 11/2/16.
//  Copyright © 2016 Stream Savvy. All rights reserved.
//

import Foundation

extension UIViewController {
    func debounce(delay: Int, queue: DispatchQueue, action: @escaping (()->()) ) -> ()->() {
        var lastFireTime   = DispatchTime.now()
        let dispatchDelay  = DispatchTimeInterval.seconds(delay)
        
        return {
            lastFireTime     = DispatchTime.now()
            let dispatchTime: DispatchTime = lastFireTime + dispatchDelay
            
            queue.asyncAfter(deadline: dispatchTime) {
                let when: DispatchTime = lastFireTime + dispatchDelay
                let now = DispatchTime.now()
                if now.rawValue >= when.rawValue {
                    action()
                }
			         }
        }
    }

}

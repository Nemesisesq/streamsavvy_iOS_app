//
//  SwiftExtensions.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 12/1/16.
//  Copyright © 2016 StreamSavvy. All rights reserved.
//

import Foundation

class Callback {
    let handler:()->()
    init(_ handler:@escaping ()->()) {
        self.handler = handler
    }
    @objc func go() {
        handler()
    }
}

// Return a function which debounces a callback,
// to be called at most once within `delay` seconds.
// If called again within that time, cancels the original call and reschedules.
func debounce(delay:TimeInterval, action:@escaping ()->()) -> ()->() {
    let callback = Callback(action)
    var timer: Timer?
    return {
        // if calling again, invalidate the last timer
        if let timer = timer {
            timer.invalidate()
        }
        timer = Timer(timeInterval: delay, target: callback, selector: #selector(Callback.go), userInfo: nil, repeats: false)
        RunLoop.current.add(timer!, forMode: RunLoopMode.defaultRunLoopMode)
    }
}

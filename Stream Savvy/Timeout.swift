//
//  Timeout.swift
//  Stream Savvy
//
//  Created by Carl Lewis on 12/14/16.
//  Copyright © 2016 StreamSavvy. All rights reserved.
//

import Foundation


class Timeout: NSObject
{
    private var timer: Timer?
    private var callback: ((Void) -> Void)?
    
    init(_ delaySeconds: Double, _ callback: @escaping (Void) -> Void)
    {
        super.init()
        self.callback = callback
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(delaySeconds),
                                          target: self, selector: #selector(self.invoke), userInfo: nil, repeats: false)
    }
    
    func invoke()
    {
        self.callback?()
        // Discard callback and timer.
        self.callback = nil
        self.timer = nil
    }
    
    func cancel()
    {
        self.timer?.invalidate()
        self.timer = nil
    }
}

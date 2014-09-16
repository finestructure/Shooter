//
//  Utils.swift
//  Shooter
//
//  Created by Sven Schmidt on 16/09/2014.
//  Copyright (c) 2014 feinstruktur. All rights reserved.
//

import Foundation


//  Usage:
//
//  let retVal = delay(2.0) {
//    println("Later")
//  }
//
//  delay(1.0) {
//    cancel_delay(retVal)
//  }
//
// Ref: http://sebastienthiebaud.us/blog/ios/gcd/block/2014/04/09/diggint-into-gcd-1-cancel-dispatch-after.html
//

typealias dispatch_cancelable_closure = (cancel : Bool) -> ()


func delay(time:NSTimeInterval, closure:()->()) ->  dispatch_cancelable_closure? {
    
    func dispatch_later(clsr:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(time * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), clsr)
    }
    
    var closure:dispatch_block_t? = closure
    var cancelableClosure:dispatch_cancelable_closure?
    
    let delayedClosure:dispatch_cancelable_closure = { cancel in
        if let clsr = closure {
            if (cancel == false) {
                dispatch_async(dispatch_get_main_queue(), clsr);
            }
        }
        closure = nil
        cancelableClosure = nil
    }
    
    cancelableClosure = delayedClosure
    
    dispatch_later {
        if let delayedClosure = cancelableClosure {
            delayedClosure(cancel: false)
        }
    }
    
    return cancelableClosure;
}

func cancel_delay(closure:dispatch_cancelable_closure?) {
    
    if closure != nil {
        closure!(cancel: true)
    }
}

// usage

//
//  acc.swift
//  NervousMagicApps
//
//  Created by sid on 19/12/15.
//  Copyright © 2015 ethz. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion


private let _acc = acc()

class acc : NSObject {
    
    let manager = CMMotionManager()
    
    override init(){
        super.init()
    }
    
    class var sharedInstance: acc {
        return _acc
    }
    
    func getAcc() -> CGPoint {
        var accData = CGPoint(x:Int(arc4random()%1000),y:Int(arc4random()%1000))
        self.manager.startAccelerometerUpdates()
        
        if manager.accelerometerAvailable {
            manager.accelerometerUpdateInterval = 0.5
            if let accelerometerData = manager.accelerometerData {
                accData = CGPoint(x: accelerometerData.acceleration.y, y: accelerometerData.acceleration.x)
            }
        }
        self.manager.stopAccelerometerUpdates()
        
        return accData
    }
}
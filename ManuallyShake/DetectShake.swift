//
//  DetectShake.swift
//  ManuallyShake
//
//  Created by Kj Drougge on 2014-12-22.
//  Copyright (c) 2014 kj. All rights reserved.
//

import Foundation
import CoreMotion


class DetectShake{
    
    
    let manager = CMMotionManager()
    let motionQueue = NSOperationQueue()
    
    var xAccel: Float!
    var yAccel: Float!
    var zAccel: Float!
    
    var xPrevAccel: Float!
    var yPrevAccel: Float!
    var zPrevAccel: Float!
    
    var shakeThreshold: Float = 1.5
    
    var firstUpdate = true
    var shakeInitiated = false
    
    
    
    func shake(){
        
        if manager.accelerometerAvailable{
            manager.accelerometerUpdateInterval = 1/10
            manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler:
                {(data: CMAccelerometerData!, error: NSError!) in
                    
                    self.updateAccelParameters(Float(data.acceleration.x), yNewAccel: Float(data.acceleration.y), zNewAccel: Float(data.acceleration.z))
                    
                    if ((!self.shakeInitiated) && self.isAccelerationChanged()) {
                        self.shakeInitiated = true;
                    } else if ((self.shakeInitiated) && self.isAccelerationChanged()) {
                        
                        println("SHAKE SHAKE")
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            //self.flower.texture = SKTexture(imageNamed: Flower2TextureImage)
                            //self.flower.setScale(0.25)
                            //self.fallingLeaves()
                        })
                        
                    } else if ((self.shakeInitiated) && (!self.isAccelerationChanged())) {
                        self.shakeInitiated = false;
                    }
            })
            
        }
        
    }
    
    
    func updateAccelParameters(xNewAccel: Float, yNewAccel: Float, zNewAccel: Float) {
        if (firstUpdate) {
            xPrevAccel = xNewAccel
            yPrevAccel = yNewAccel
            zPrevAccel = zNewAccel
            firstUpdate = false
        } else {
            xPrevAccel = xAccel
            yPrevAccel = yAccel
            zPrevAccel = zAccel
        }
        xAccel = xNewAccel
        yAccel = yNewAccel
        zAccel = zNewAccel
    }
    
    func isAccelerationChanged() -> Bool{
        var deltaX: Float = abs(xPrevAccel - xAccel);
        var deltaY: Float = abs(yPrevAccel - yAccel);
        var deltaZ: Float = abs(zPrevAccel - zAccel);
        return (deltaX > shakeThreshold && deltaY > shakeThreshold) || (deltaX > shakeThreshold && deltaZ > shakeThreshold) || (deltaY > shakeThreshold && deltaZ > shakeThreshold)
    }
    

    
}
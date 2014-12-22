//
//  ViewController.swift
//  ManuallyShake
//
//  Created by Kj Drougge on 2014-12-22.
//  Copyright (c) 2014 kj. All rights reserved.
//

import UIKit


class ViewController: UIViewController, ShakeMotionDeligate {

    
    var shake:ShakeMotion = ShakeMotion();

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shake.deligate = self;
        shake.startShake();
        // Do any additional setup after loading the view, typically from a nib.
    }

    func shakeFound() {
        println("SHAHAHJAKAKAKAKEKKEKEKKAKKEKKSKAS");
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


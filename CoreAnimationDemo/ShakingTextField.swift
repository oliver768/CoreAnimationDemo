//
//  ShakingTextField.swift
//  CoreAnimationDemo
//
//  Created by Ravindra Sonkar on 23/11/18.
//  Copyright © 2018 Ravindra Sonkar. All rights reserved.
//

import UIKit

class ShakingTextField: UITextField {

    func shaking() {
        let coreAnimate = CABasicAnimation(keyPath:  "position")
        coreAnimate.duration = 0.05
        coreAnimate.repeatCount = 5
        coreAnimate.autoreverses = true
        coreAnimate.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        coreAnimate.toValue =  NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(coreAnimate, forKey: "position")
    }

}

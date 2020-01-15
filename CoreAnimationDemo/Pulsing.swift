//
//  Posing.swift
//  CoreAnimationDemo
//
//  Created by Ravindra Sonkar on 23/11/18.
//  Copyright © 2018 Ravindra Sonkar. All rights reserved.
//

import UIKit

class Pulsing: CALayer {

    var animate = CAAnimationGroup()
    var initialPulseScale : Float = 0
    var nextPulseAfter : TimeInterval = 0
    var animationDuration : TimeInterval = 1.5
    var radius : Float = 200
    var numberOfPulse : Float = Float.infinity
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(numberOfPulse : Float = Float.infinity, redius : Float, position : CGPoint) {
        super.init()
        self.backgroundColor = UIColor.black.cgColor
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0
        self.radius = redius
        self.numberOfPulse = numberOfPulse
        self.position = position
        self.bounds = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(radius * 2), height: CGFloat(radius * 2))
        self.cornerRadius = CGFloat(radius)
        
        DispatchQueue.global(qos: .default).async {
            self.setUpAnimationGroup()
        }
        DispatchQueue.main.async {
            self.add(self.animate, forKey: "pulse")
        }
    }
    
    func createAnimationWithScale() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(value : initialPulseScale)
        scaleAnimation.toValue = NSNumber(value: 1)
        scaleAnimation.duration = animationDuration
        return scaleAnimation
    }
    
    func createAnimationWithOpacity() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.values = [0.4, 0.8 , 0]
        opacityAnimation.keyTimes = [0.0, 0.2, 1]
        opacityAnimation.duration = animationDuration
        return opacityAnimation
    }
    
    func setUpAnimationGroup() {
        self.animate = CAAnimationGroup()
        self.animate.duration = animationDuration + nextPulseAfter
        self.animate.repeatCount = numberOfPulse
        let defaultCurve = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        self.animate.timingFunction = defaultCurve
        self.animate.animations = [createAnimationWithScale(), createAnimationWithOpacity()]
    }
}

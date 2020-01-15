//
//  ViewController.swift
//  CoreAnimationDemo
//
//  Created by Ravindra Sonkar on 23/11/18.
//  Copyright © 2018 Ravindra Sonkar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewOutlet: UIView!
    @IBOutlet weak var userTextField: ShakingTextField!
    @IBOutlet weak var avtarImageView: UIImageView!
    
    let progressShape = CAShapeLayer()
    let backgroundShape = CAShapeLayer()
    var percent = 0.0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.addSublayer(backgroundShape)
        view.layer.addSublayer(progressShape)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapping))
        tapGesture.numberOfTapsRequired = 1
        avtarImageView.addGestureRecognizer(tapGesture)
        viewOutlet.isHidden = true
        avtarImageView.isHidden = true
        
    }

    @objc func tapping() {
        let pulse = Pulsing(numberOfPulse: 1, redius: 110, position: viewOutlet.center)
        pulse.backgroundColor = UIColor.blue.cgColor
        pulse.animationDuration = 0.8
        self.view.layer.insertSublayer(pulse, below: avtarImageView.layer)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension ViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        userTextField.shaking()
    }
    
    func updateIndicator(with percent: Double, isAnimated: Bool = false) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = progressShape.strokeEnd
        animation.toValue = percent / 100.0
        animation.duration = 30.0
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
        
        
        let strokeWidth: CGFloat = 20.0
        let frame = CGRect(x: 0, y: 0, width: viewOutlet.frame.size.width - strokeWidth, height: viewOutlet.frame.size.height - strokeWidth)
        
        backgroundShape.frame = frame
        
        backgroundShape.position = view.center
        backgroundShape.path = UIBezierPath(ovalIn: frame).cgPath
        backgroundShape.strokeColor = UIColor.black.cgColor
        backgroundShape.lineWidth = strokeWidth
        backgroundShape.fillColor = UIColor.clear.cgColor
        
        progressShape.frame = frame
        progressShape.path = backgroundShape.path
        progressShape.position = backgroundShape.position
        progressShape.strokeColor = UIColor.red.cgColor
        progressShape.lineWidth = backgroundShape.lineWidth
        progressShape.fillColor = UIColor.clear.cgColor
        progressShape.strokeEnd = -90.0
        
        if isAnimated {
            progressShape.add(animation, forKey: nil)
        }
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateIndicator(with: percent, isAnimated: true)
    }

}

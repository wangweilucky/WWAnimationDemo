//
//  WWRotateView.swift
//  WWAnimation
//
//  Created by wangwei on 2018/9/12.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

class WWRotateView: UIView {

    let strokeColor = UIColor.black.cgColor
    let strokeThickness: CGFloat = 2.0
    var radius: CGFloat {
        return self.bounds.width * 0.5
    }
    
    var progressAnimatedLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initMyView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initMyView()
    }
    
    func initMyView() {
        
        let arcCenter = CGPoint(x: radius + strokeThickness * 0.5 + 5,
                                y: radius + strokeThickness * 0.5 + 5)
        
        let smoothedPath = UIBezierPath(arcCenter: arcCenter,
                                        radius: radius,
                                        startAngle: CGFloat(Double.pi * 1.5),
                                        endAngle: (CGFloat(Double.pi * 1.5 + Double.pi * 2)) ,
                                        clockwise: true)
        
        self.progressAnimatedLayer = CAShapeLayer()
        progressAnimatedLayer.contentsScale = UIScreen.main.scale
        progressAnimatedLayer.fillColor = UIColor.clear.cgColor
        progressAnimatedLayer.strokeColor = strokeColor
        progressAnimatedLayer.lineWidth = strokeThickness
        progressAnimatedLayer.lineCap = kCALineCapRound
        progressAnimatedLayer.lineJoin = kCALineJoinBevel
        progressAnimatedLayer.path = smoothedPath.cgPath
        progressAnimatedLayer.strokeStart = 0
        progressAnimatedLayer.strokeEnd = 0.9
        progressAnimatedLayer.frame = CGRect(x: 0,
                                             y: 0,
                                             width: arcCenter.x * 2,
                                             height: arcCenter.y * 2)
        
        self.layer.addSublayer(progressAnimatedLayer)
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.duration = 0.9
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.repeatCount = Float(Double.infinity)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        progressAnimatedLayer.add(animation, forKey: "transformRotation")
        
    }

}

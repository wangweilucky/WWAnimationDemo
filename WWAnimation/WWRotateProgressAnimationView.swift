//
//  WWRotateProgressAnimationView.swift
//  WWAnimation
//
//  Created by wangwei on 2018/9/12.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

class WWRotateProgressAnimationView: UIView {

    let beginTime: Double = 0.5
    let strokeStartDuration: Double = 1.2
    let strokeEndDuration: Double = 0.7
    
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
        progressAnimatedLayer.strokeEnd = 1
        progressAnimatedLayer.frame = CGRect(x: 0,
                                             y: 0,
                                             width: arcCenter.x * 2,
                                             height: arcCenter.y * 2)
        
        self.layer.addSublayer(progressAnimatedLayer)
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
//        rotationAnimation.byValue = Float.pi * 2
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = Float.pi * 2
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.duration = strokeEndDuration
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.duration = strokeStartDuration
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1
        strokeStartAnimation.beginTime = beginTime
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [rotationAnimation, strokeEndAnimation, strokeStartAnimation]
        groupAnimation.duration = strokeStartDuration + beginTime
        groupAnimation.repeatCount = .infinity
//        groupAnimation.isRemovedOnCompletion = false
//        groupAnimation.fillMode = kCAFillModeForwards
        
        progressAnimatedLayer.add(groupAnimation, forKey: "groupAnimations")
        
    }


}

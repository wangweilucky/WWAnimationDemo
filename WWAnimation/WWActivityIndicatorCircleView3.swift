//
//  WWActivityIndicatorCircleView3.swift
//  WWAnimation
//
//  Created by wangwei on 2018/9/20.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

class WWActivityIndicatorCircleView3: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initMyView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initMyView()
    }
    
    func initMyView() {
        setUpAnimation(in: self.layer, size: self.frame.size, color: UIColor.black)
    }
    
    func setUpAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
        
        let circleSpacing: CGFloat = 4
        let circleSize: CGFloat = (size.width - 2 * circleSpacing) / 3
        let duration: CFTimeInterval = 1
        let beginTime : CFTimeInterval = CFAbsoluteTimeGetCurrent()
        let timingFunction : CAMediaTimingFunction = CAMediaTimingFunction(controlPoints: 0.7, 0, 0.1, 0.1)
        
        
        // 圆的了路径
//        let ringPath = UIBezierPath()
//        ringPath.addArc(withCenter: self.center, radius: self.layer.bounds.width * 0.5 - circleSize, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: false)
//
        let animationA = CAKeyframeAnimation(keyPath: "transform.rotation")
        animationA.keyTimes = [0, 0.5, 1]
        animationA.values = [0, Float.pi, Float.pi * 2]
        animationA.duration = duration
        animationA.repeatCount = HUGE
        animationA.isRemovedOnCompletion = false
        animationA.timingFunctions = [timingFunction, timingFunction]
        
        let animationB = CAKeyframeAnimation(keyPath: "transform.scale")
        animationB.keyTimes = [0, 0.5, 1]
        animationB.values = [1, 0.4, 1]
        animationB.duration = duration
        animationB.repeatCount = HUGE
        animationB.isRemovedOnCompletion = false
        
    
        let leftCircle = ActivityIndicatorShape.circle.layerWith(size:
            CGSize(width: circleSize, height: circleSize), color: color)
        leftCircle.add(animationB, forKey: "animationB")
        leftCircle.opacity = 0.8
        
        let centerCircle = ActivityIndicatorShape.circle.layerWith(size:
            CGSize(width: circleSize, height: circleSize), color: color)
        centerCircle.add(animationB, forKey: "animationB")
        
        let rightCircle = ActivityIndicatorShape.circle.layerWith(size:
            CGSize(width: circleSize, height: circleSize), color: color)
        rightCircle.add(animationB, forKey: "animationB")
        rightCircle.opacity = 0.8
        
        centerCircle.frame = CGRect(x: size.width * 0.5 - circleSize * 0.5,
                              y: size.height * 0.5 - circleSize * 0.5,
                              width: circleSize,
                              height: circleSize)
        
        leftCircle.frame = CGRect(x: 0,
                                      y: size.height * 0.5 - circleSize * 0.5,
                                      width: circleSize,
                                      height: circleSize)
        
        rightCircle.frame = CGRect(x: size.width - circleSize,
                                      y: size.height * 0.5 - circleSize * 0.5,
                                      width: circleSize,
                                      height: circleSize)
        
        
        let circle = CALayer()
//        circle.backgroundColor = UIColor.blue.cgColor
        let frame = CGRect(x: (layer.bounds.size.width - size.width) / 2, y: (layer.bounds.size.height - size.height) / 2, width: size.width, height: size.height)
        
        circle.frame = frame
        
        circle.addSublayer(leftCircle)
        circle.addSublayer(rightCircle)
        circle.addSublayer(centerCircle)
        circle.add(animationA, forKey: "animationA")
        layer.addSublayer(circle)
        
    }
}

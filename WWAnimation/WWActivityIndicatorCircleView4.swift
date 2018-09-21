//
//  WWActivityIndicatorCircleView4.swift
//  WWAnimation
//
//  Created by wangwei on 2018/9/20.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

class WWActivityIndicatorCircleView4: UIView {

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
        
        let circleSpacing: CGFloat = 5
        let circleSize: CGFloat = (size.width - 2 * circleSpacing) / 3
        let duration: CFTimeInterval = 0.6
        let beginTime : CFTimeInterval = CACurrentMediaTime()
        let beginTimes : [CFTimeInterval] = [0.1, 0.2, 0.3]
//        let deltaY = (size.height / 2 - circleSize / 2) / 2
        let timingFunciton = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let animationB = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animationB.values = [0, layer.bounds.height - circleSize, 0]
        animationB.keyTimes = [0, 0.5, 1]
        animationB.timingFunctions = [timingFunciton, timingFunciton]
        animationB.duration = duration
        animationB.repeatCount = HUGE
        animationB.isRemovedOnCompletion = false
        
        for i in 0..<3 {
            let circle = ActivityIndicatorShape.circle.layerWith(size:
                CGSize(width: circleSize, height: circleSize), color: color)
            circle.frame = CGRect(x: circleSize * CGFloat(i) + circleSpacing * CGFloat(i), y: 0, width: circleSize, height: circleSize)
            animationB.beginTime = beginTime + beginTimes[i]
            circle.add(animationB, forKey: "animationB")
            layer.addSublayer(circle)
        }
        
    }

}

//
//  NVActivityIndicatorCircleView1.swift
//  WWAnimation
//
//  Created by wangwei on 2018/9/19.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

class WWActivityIndicatorCircleView1: UIView {

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
    
        let circleSpacing: CGFloat = 2
        let circleSize: CGFloat = (size.width - 2 * circleSpacing) / 3
        let duration: CFTimeInterval = 0.75
//        let beginTime = CACurrentMediaTime()
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.68, 0.18, 1.08)
        
        // Animation
        let animationA = CAKeyframeAnimation(keyPath: "transform.scale")
        animationA.keyTimes = [0, 0.3, 1]
        animationA.timingFunctions = [timingFunction, timingFunction]
        animationA.values = [1, 0.3, 1]
        animationA.duration = duration
        animationA.repeatCount = HUGE
        animationA.isRemovedOnCompletion = false
        
        let circle = ActivityIndicatorShape.circle.layerWith(size: CGSize(width: circleSize, height: circleSize), color: color)
        circle.add(animationA, forKey: "Animation_Circle")
        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.instanceCount = 3
        replicatorLayer.instanceDelay = 0.12
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(circleSize + circleSpacing, 0, 0)
        replicatorLayer.addSublayer(circle)
        replicatorLayer.frame = layer.bounds
        layer.addSublayer(replicatorLayer)
        
        
        // Draw circles
//        for i in 0 ..< 3 {
//            let circle = NVActivityIndicatorShape.circle.layerWith(size: CGSize(width: circleSize, height: circleSize), color: color)
//            let frame = CGRect(x: x + circleSize * CGFloat(i) + circleSpacing * CGFloat(i),
//                               y: y,
//                               width: circleSize,
//                               height: circleSize)
//
//            animation.beginTime = beginTime + beginTimes[i]
//            circle.frame = frame
//            circle.add(animation, forKey: "animation")
//            layer.addSublayer(circle)
//        }
    }
}

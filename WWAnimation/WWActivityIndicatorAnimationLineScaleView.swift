//
//  ActivityIndicatorAnimationLineScaleView.swift
//  WWAnimation
//
//  Created by wangwei on 2018/9/14.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

class WWActivityIndicatorAnimationLineScaleView: UIView {

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
        
        let lineSize = size.width / 9
        
        let line = ActivityIndicatorShape.line.layerWith(size: CGSize(width: lineSize, height: size.height), color: color)
        
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.68, 0.18, 1.08)
        let duration: CFTimeInterval = 0.9
//        let animation = CABasicAnimation(keyPath: "transform.scale.y")
        let animation = CAKeyframeAnimation(keyPath: "transform.scale.y")
        animation.keyTimes = [0, 0.5, 1]
        animation.values = [1, 0.4, 1]
        animation.duration = duration
        animation.timingFunctions = [timingFunction, timingFunction]
        animation.repeatCount = HUGE
        animation.autoreverses = false
        animation.isRemovedOnCompletion = false
        line.add(animation, forKey: "lineAnimation")
        
        let replecatorLayer = CAReplicatorLayer()
        replecatorLayer.addSublayer(line)
        replecatorLayer.instanceCount = 5
        replecatorLayer.instanceDelay = 0.1
        replecatorLayer.instanceTransform = CATransform3DMakeTranslation(lineSize * 2, 0, 0)
        
        layer.addSublayer(replecatorLayer)
    }
    
//    func setUpAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
//
//        let frame = CGRect(x: x + lineSize * 2 * CGFloat(i), y: y, width: lineSize, height: size.height)
//
//
//        let lineSize = size.width / 9
//        let x = (layer.bounds.size.width - size.width) / 2
//        let y = (layer.bounds.size.height - size.height) / 2
//        let duration: CFTimeInterval = 1
//        let beginTime = CACurrentMediaTime()
//        let beginTimes = [0.1, 0.2, 0.3, 0.4, 0.5]
//        let timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.68, 0.18, 1.08)
//
//        // Animation
////        let animation = CAKeyframeAnimation(keyPath: "transform.scale.y")
//        let animation = CABasicAnimation(keyPath: "transform.scale.y")
//
////        animation.keyTimes = [0, 0.5, 1]
////        animation.timingFunctions = [timingFunction, timingFunction]
////        animation.values = [1, 0.4, 1]
//
//        animation.fromValue = 1
//        animation.toValue = 0.4
//        animation.autoreverses = true
//        animation.timingFunction = timingFunction
//
//        animation.duration = duration
//        animation.repeatCount = HUGE
//        animation.isRemovedOnCompletion = false
//
//        // Draw lines
//        for i in 0 ..< 5 {
//            let line = ActivityIndicatorShape.line.layerWith(size: CGSize(width: lineSize, height: size.height), color: color)
//            let frame = CGRect(x: x + lineSize * 2 * CGFloat(i), y: y, width: lineSize, height: size.height)
//
//            animation.beginTime = beginTime + beginTimes[i]
//            line.frame = frame
//            line.add(animation, forKey: "animation")
//            layer.addSublayer(line)
//        }
//    }

}

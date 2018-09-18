//
//  WWActivityIndicatorAnimationLineScalePulseOutView.swift
//  WWAnimation
//
//  Created by wangwei on 2018/9/18.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

class WWActivityIndicatorAnimationLineScalePulseOutView: UIView {

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
        let x = (layer.bounds.size.width - size.width) / 2
        let y = (layer.bounds.size.height - size.height) / 2
        let duration: CFTimeInterval = 1
        let beginTime = CACurrentMediaTime()
//        let beginTimes: [CFTimeInterval] = [0.4, 0.2, 0, 0.2, 0.4]
        let beginTimes: [CFTimeInterval] = [0, 0.2, 0.4, 0.2, 0]
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.85, 0.25, 0.37, 0.85)
        
        // Animation
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.keyTimes = [0, 0.5, 1]
        animation.timingFunctions = [timingFunction, timingFunction]
        animation.values = [1, 0.5, 1]
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        
        for i in 0...4 {
            let line = ActivityIndicatorShape.line.layerWith(size: CGSize(width: lineSize, height: size.height), color: color)
            let frame = CGRect(x: x + lineSize * 2 * CGFloat(i), y: y, width: lineSize, height: size.height)
            
            animation.beginTime = beginTimes[i] + beginTime
            animation.duration = duration
            line.frame = frame
            line.add(animation, forKey: "lineAnimation")
            layer.addSublayer(line)
        }
    }


}

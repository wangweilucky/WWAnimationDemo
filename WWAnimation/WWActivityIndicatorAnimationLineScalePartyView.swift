//
//  WWActivityIndicatorAnimationLineScaleParty.swift
//  WWAnimation
//
//  Created by wangwei on 2018/9/14.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

class WWActivityIndicatorAnimationLineScalePartyView: UIView {

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
        let lineSize = size.width / 7
        let x = (layer.bounds.size.width - size.width) / 2
        let y = (layer.bounds.size.height - size.height) / 2
        let durations: [CFTimeInterval] = [1.26, 0.43, 1.01, 0.73]
        let beginTime = CACurrentMediaTime()
        let beginTimes: [CFTimeInterval] = [0.77, 0.29, 0.28, 0.74]
        let timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        
        // Animation
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.keyTimes = [0, 0.5, 1]
        animation.timingFunctions = [timingFunction, timingFunction]
        animation.values = [1, 0.5, 1]
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        
        for i in 0..<4 {
            let line = ActivityIndicatorShape.line.layerWith(size: CGSize(width: lineSize, height: size.height), color: color)
            let frame = CGRect(x: x + lineSize * 2 * CGFloat(i), y: y, width: lineSize, height: size.height)
            
            animation.beginTime = beginTimes[i] + beginTime
            animation.duration = durations[i]
            line.frame = frame
            line.add(animation, forKey: "lineAnimation")
            layer.addSublayer(line)
        }
    }

}

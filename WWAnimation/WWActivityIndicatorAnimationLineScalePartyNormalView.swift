//
//  WWActivityIndicatorAnimationLineScalePartyNormalView.swift
//  WWAnimation
//
//  Created by wangwei on 2018/9/14.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

class WWActivityIndicatorAnimationLineScalePartyNormalView: UIView {

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
        let timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        
        // Animation
        // 控制透明度
        let animationA = CAKeyframeAnimation(keyPath: "alpha")
        animationA.keyTimes = [0, 0.5, 1]
        animationA.timingFunctions = [timingFunction, timingFunction]
        animationA.values = [1, 0.5, 1]
        
        // 控制纵向的大小
        let animationB = CAKeyframeAnimation(keyPath: "transform.scale")
        animationB.keyTimes = [0, 0.5, 1]
        animationB.timingFunctions = [timingFunction, timingFunction]
        animationB.values = [1, 0.5, 1]
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animationA, animationB]
        animationGroup.duration = 0.5
        animationGroup.repeatCount = HUGE
        animationGroup.isRemovedOnCompletion = false
        
        let line = ActivityIndicatorShape.line.layerWith(size: CGSize(width: lineSize, height: size.height), color: color)
        line.add(animationGroup, forKey: "WWActivityIndicatorAnimationLineScalePartyNormalView")
        
        let replecatorLayer = CAReplicatorLayer()
        replecatorLayer.addSublayer(line)
        replecatorLayer.instanceCount = 5
        replecatorLayer.instanceDelay = 0.1
        replecatorLayer.instanceTransform = CATransform3DMakeTranslation(lineSize * 2, 0, 0)
        layer.addSublayer(replecatorLayer)
        // CAReplicatorLayer不能对subView的属性，beginTime、timingFunction、duration进行单个设置。
    }
}

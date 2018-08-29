//
//  WWIndefiniteAnimatedView.swift
//  WWAnimation
//
//  Created by 王大吉 on 28/8/18.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

class WWIndefiniteAnimatedView: UIView {
    
    let strokeColor = UIColor.black
    let strokeThickness: CGFloat = 2.0
    let radius: CGFloat = 16.0
    
    lazy var indefiniteAnimatedLayer: CAShapeLayer = {
        
        let arcCenter = CGPoint(x: radius + strokeThickness * 0.5 + 5,
                                y: radius + strokeThickness * 0.5 + 5)
        
        let smoothedPath = UIBezierPath(arcCenter: arcCenter,
                                        radius: radius,
                                        startAngle: CGFloat(Double.pi * 1.5),
                                        endAngle: (CGFloat(Double.pi * 1.5 + Double.pi * 2)) ,
                                        clockwise: true)
        
        var indefiniteAnimatedLayer = CAShapeLayer()
        indefiniteAnimatedLayer.contentsScale = UIScreen.main.scale
        
        indefiniteAnimatedLayer.frame = CGRect(x: 0,
                                               y: 0,
                                               width: arcCenter.x * 2,
                                               height: arcCenter.y * 2)
        indefiniteAnimatedLayer.fillColor = UIColor.clear.cgColor
        indefiniteAnimatedLayer.strokeColor = strokeColor.cgColor
        indefiniteAnimatedLayer.lineWidth = strokeThickness
        indefiniteAnimatedLayer.lineCap = kCALineCapRound
        indefiniteAnimatedLayer.lineJoin = kCALineJoinBevel
        indefiniteAnimatedLayer.path = smoothedPath.cgPath
        
        let linearCurve = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        // mask的不透明内容和layer的叠加部分才能显示
        var maskLayer = CAShapeLayer()
        let maskContent =  UIImage(named: "angle-mask")?.cgImage
        maskLayer.contents = maskContent
        maskLayer.frame = indefiniteAnimatedLayer.bounds
        indefiniteAnimatedLayer.mask = maskLayer
        
        let animationDuration : TimeInterval = 1
        var animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = animationDuration
        animation.isRemovedOnCompletion = false
        animation.repeatCount = .infinity
        animation.fillMode = kCAFillModeForwards
        animation.autoreverses = false
        animation.timingFunction = linearCurve// 将动画设置为线性的
    
        maskLayer.add(animation, forKey: "rotate")
        
        // 不加这段也是可以的，为啥
//        let animationGroup = CAAnimationGroup()
//        animationGroup.duration = animationDuration
//        animationGroup.repeatCount = .infinity;
//        animationGroup.isRemovedOnCompletion = false;
//        animationGroup.timingFunction = linearCurve;
//
//        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
//        strokeStartAnimation.fromValue = 0.015;
//        strokeStartAnimation.toValue = 0.515;
//
//        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        strokeEndAnimation.fromValue = 0.485;
//        strokeEndAnimation.toValue = 0.985;
//
//        animationGroup.animations = [strokeStartAnimation, strokeEndAnimation];
//        indefiniteAnimatedLayer.add(animationGroup, forKey: "progress")
        
        return indefiniteAnimatedLayer
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.addSublayer(indefiniteAnimatedLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

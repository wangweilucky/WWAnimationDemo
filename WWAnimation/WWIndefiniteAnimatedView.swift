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
    var radius: CGFloat {
        return self.bounds.width * 0.5
    }
    
    lazy var indefiniteAnimatedLayer: CAShapeLayer = {
        
        let arcCenter = CGPoint(x: radius + strokeThickness * 0.5 + 5,
                                y: radius + strokeThickness * 0.5 + 5)
        
        let smoothedPath = UIBezierPath(arcCenter: arcCenter,
                                        radius: radius,
                                        startAngle: CGFloat(Double.pi * 1.5),
                                        endAngle: (CGFloat(Double.pi * 1.5 + Double.pi * 2)) ,
                                        clockwise: true)
        
        var indefiniteAnimatedLayer = CAShapeLayer()
        indefiniteAnimatedLayer.contentsScale = UIScreen.main.scale // 为了图片让Retain屏幕上正常显示
        indefiniteAnimatedLayer.fillColor = UIColor.clear.cgColor   // 填充色
        indefiniteAnimatedLayer.strokeColor = strokeColor.cgColor   // 描边色
        indefiniteAnimatedLayer.lineWidth = strokeThickness         // 线条宽度
        indefiniteAnimatedLayer.lineCap = kCALineCapRound           // 线条首尾的外观
        indefiniteAnimatedLayer.lineJoin = kCALineJoinBevel         // 线条连接处的外观，圆滑、折线、棱角
        indefiniteAnimatedLayer.path = smoothedPath.cgPath
        indefiniteAnimatedLayer.frame = CGRect(x: 0,
                                               y: 0,
                                               width: arcCenter.x * 2,
                                               height: arcCenter.y * 2)
        
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
        
        // 不加这段也是可以的?
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
        super.init(coder: aDecoder)
        
        self.layer.addSublayer(indefiniteAnimatedLayer)
    }
}

//
//  WWProgressAnimatedView.swift
//  WWAnimation
//
//  Created by 王大吉 on 29/8/18.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

class WWProgressAnimatedView: UIView {

    let strokeColor = UIColor.black.cgColor
    let strokeThickness: CGFloat = 2.0
    var radius: CGFloat {
        return self.bounds.width * 0.5
    }
    
    var progressAnimatedLayer = CAShapeLayer()
    
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
        progressAnimatedLayer.strokeEnd = 0
        progressAnimatedLayer.frame = CGRect(x: 0,
                                             y: 0,
                                             width: arcCenter.x * 2,
                                             height: arcCenter.y * 2)
        
        self.layer.addSublayer(progressAnimatedLayer)
    }
    
    func set(fillColor: UIColor? = UIColor.clear,
             strokeColor: UIColor? = UIColor.black,
             lineWidth: CGFloat? = 2.0) {
        
        if let fillColor = fillColor { progressAnimatedLayer.fillColor = fillColor.cgColor }
        if let strokeColor = strokeColor { progressAnimatedLayer.strokeColor = strokeColor.cgColor }
        if let lineWidth = lineWidth { progressAnimatedLayer.lineWidth = lineWidth }
    }
    
    func set(progress: CGFloat) {
        var p = progress
        if p >= 1 {p = 1}
        self.progressAnimatedLayer.strokeEnd = p
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initMyView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initMyView()
    }
}

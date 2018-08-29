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
    let radius: CGFloat = 16.0
    
    var strokeEnd: CGFloat = 0{
        didSet {
            if strokeEnd == 1 {return}
            self.progressAnimatedLayer.strokeEnd = strokeEnd
        }
    }
    
    lazy var progressAnimatedLayer: CAShapeLayer = {
        
        let arcCenter = CGPoint(x: radius + strokeThickness * 0.5 + 5,
                                y: radius + strokeThickness * 0.5 + 5)
        
        let smoothedPath = UIBezierPath(arcCenter: arcCenter,
                                        radius: radius,
                                        startAngle: CGFloat(Double.pi * 1.5),
                                        endAngle: (CGFloat(Double.pi * 1.5 + Double.pi * 2)) ,
                                        clockwise: true)
        
        var progressAnimatedLayer = CAShapeLayer()
        progressAnimatedLayer.contentsScale = UIScreen.main.scale
        progressAnimatedLayer.fillColor = UIColor.clear.cgColor
        progressAnimatedLayer.strokeColor = strokeColor
        progressAnimatedLayer.lineWidth = strokeThickness
        progressAnimatedLayer.lineCap = kCALineCapRound
        progressAnimatedLayer.lineJoin = kCALineJoinBevel
        progressAnimatedLayer.path = smoothedPath.cgPath
        progressAnimatedLayer.strokeStart = 0
        progressAnimatedLayer.frame = CGRect(x: 0,
                                             y: 0,
                                             width: arcCenter.x * 2,
                                             height: arcCenter.y * 2)
        
        self.layer.addSublayer(progressAnimatedLayer)
        return progressAnimatedLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.addSublayer(progressAnimatedLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

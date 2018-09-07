//
//  RadarView.swift
//  WWAnimation
//
//  Created by wangwei on 2018/9/3.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

class WWRadarView: UIView {
    
    var animation: Bool = false
    
    var pulseLayer = CAShapeLayer()
    var pulseLayerFillColor = UIColor.orange
    
    var replicatorLayer = CAReplicatorLayer()
    var replicatorLayerInstanceCount: Int = 8
    var replicatorLayerInstanceDelay: CFTimeInterval = 1.0
    
    
    lazy var groupAnim: CAAnimationGroup = {
        
        // 动画
        let opacityAnima = CABasicAnimation(keyPath: "opacity")
        opacityAnima.fromValue = 0.3
        opacityAnima.toValue = 0
        
        let scaleAnima = CABasicAnimation(keyPath: "transform")
        scaleAnima.fromValue = NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 0, 0, 0))
        scaleAnima.toValue = NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 1, 1, 0))
        
        
        let g = CAAnimationGroup()
        g.animations = [opacityAnima, scaleAnima]
        g.duration = 4.0
        g.autoreverses = false
        g.repeatCount = Float(Double.infinity)
        return g
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initMyView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initMyView()
    }
    
    func initMyView() {
        
        self.layer.backgroundColor = UIColor.clear.cgColor
        
        pulseLayer = CAShapeLayer()
        pulseLayer.frame = self.layer.bounds
        pulseLayer.path = UIBezierPath(ovalIn: self.layer.bounds).cgPath
        pulseLayer.fillColor = UIColor.orange.cgColor
        pulseLayer.opacity = 0 // 完全透明
        
        self.replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = self.layer.bounds
        replicatorLayer.instanceCount = 8
        replicatorLayer.instanceDelay = 1.0
        
    }
}


extension WWRadarView {
    
    
    func set(fillColor: UIColor? = UIColor.orange,
             instanceCount: Int? = 8,
             instanceDelay: CFTimeInterval? = 1.0) {
        
        if let fillColor = fillColor { self.pulseLayerFillColor = fillColor }
        if let instanceCount = instanceCount { self.replicatorLayerInstanceCount = instanceCount }
        if let instanceDelay = instanceDelay { self.replicatorLayerInstanceDelay = instanceDelay }
        
    }
    
    func startAnimation() {
        if animation {return}
        pulseLayer.fillColor = pulseLayerFillColor.cgColor
        replicatorLayer.instanceCount = replicatorLayerInstanceCount
        replicatorLayer.instanceDelay = replicatorLayerInstanceDelay
        pulseLayer.add(groupAnim, forKey: "replicatorLayerAnimation")
        replicatorLayer.addSublayer(pulseLayer)
        self.layer.addSublayer(replicatorLayer)
        animation = true
    }
    
    func stopAnimation() {
        replicatorLayer.removeFromSuperlayer()
        animation = false
    }
}

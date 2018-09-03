//
//  RadarView.swift
//  WWAnimation
//
//  Created by wangwei on 2018/9/3.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

class RadarView: UIView {
    
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
        
        let pulseLayer = CAShapeLayer()
        pulseLayer.frame = self.layer.bounds
        pulseLayer.path = UIBezierPath(ovalIn: self.layer.bounds).cgPath
        pulseLayer.fillColor = UIColor.orange.cgColor
        pulseLayer.opacity = 0 // 完全透明
        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = self.layer.bounds
        replicatorLayer.instanceCount = 8
        replicatorLayer.instanceDelay = 1.0
        replicatorLayer.addSublayer(pulseLayer)
        self.layer.addSublayer(replicatorLayer)
        
        // 动画
        let opacityAnima = CABasicAnimation(keyPath: "opacity")
        opacityAnima.fromValue = 0.3
        opacityAnima.toValue = 0
        
        let scaleAnima = CABasicAnimation(keyPath: "transform")
        scaleAnima.fromValue = NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 0, 0, 0))
        scaleAnima.toValue = NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 1, 1, 0))
        
        let groupAnim = CAAnimationGroup()
        groupAnim.animations = [opacityAnima, scaleAnima]
        groupAnim.duration = 4.0
        groupAnim.autoreverses = false
        groupAnim.repeatCount = Float(Double.infinity)
        pulseLayer.add(groupAnim, forKey: "replicatorLayerAnimation")
        
    }
}

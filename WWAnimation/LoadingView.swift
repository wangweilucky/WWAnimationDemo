//
//  LoadingView.swift
//  WWAnimation
//
//  Created by wangwei on 2018/9/5.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initMyView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initMyView()
    }
    
    func initMyView() {
    
        let myLayer = CALayer()
        myLayer.backgroundColor = UIColor.red.cgColor
        myLayer.frame = CGRect(x: 0, y: 0, width: 20, height: 100)
        
        
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = 100
        animation.toValue = 50
        animation.duration = 0.6
        animation.repeatCount = Float(Double.infinity)
        animation.autoreverses = true
        myLayer.add(animation, forKey: "sizeHeight")
        
        
        let replicateLayer = CAReplicatorLayer()
        replicateLayer.frame = self.bounds // 需要将replicateLayer的frame设置大一点，里面的创建的多个子layer都会排放在里面
        replicateLayer.instanceCount = 3
        replicateLayer.instanceDelay = 0.2
        replicateLayer.instanceTransform = CATransform3DMakeTranslation(20 + 8, 0, 0)
        replicateLayer.addSublayer(myLayer)
        replicateLayer.masksToBounds = true
        self.layer.addSublayer(replicateLayer)

    }

}

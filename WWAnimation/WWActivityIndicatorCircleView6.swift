//
//  WWActivityIndicatorCircleView6.swift
//  WWAnimation
//
//  Created by wangwei on 2018/9/20.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

class WWActivityIndicatorCircleView6: UIView {

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
        
        //
    }
    
    func circleAt(frame: CGRect, layer: CALayer, size: CGSize, color: UIColor, animation: CAAnimation) {
        let circle = ActivityIndicatorShape.circle.layerWith(size: size, color: color)
        
        circle.frame = frame
        circle.add(animation, forKey: "animation")
        layer.addSublayer(circle)
    }

}

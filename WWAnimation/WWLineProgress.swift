//
//  ProgressView.swift
//  WWAnimation
//
//  Created by wangwei on 2018/9/5.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

class WWLineProgress: UIView {

    var progresslayer = CAShapeLayer()
    var progressStrokeEnd: CGFloat = 0
    var progressLineCap: String = ""
    var progressLineJoin: String = ""
    var type : CapLine = .capround
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initMyView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initMyView()
    }
    
    func initMyView() {
        
        let cor = self.frame.height * 0.5
        
        layer.cornerRadius = cor
        layer.masksToBounds = true
        
        self.progresslayer = CAShapeLayer()
        progresslayer.contentsScale = UIScreen.main.scale
        progresslayer.frame = self.bounds
        
        progresslayer.fillColor = UIColor.clear.cgColor
        progresslayer.strokeColor = UIColor.red.cgColor
        progresslayer.lineWidth = self.bounds.height // 设置线宽度， 需要注意的是： 线的y值需要向下移动
        progresslayer.lineCap = kCALineCapRound
        progresslayer.lineJoin = kCALineJoinBevel
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: cor, y: cor))
        path.addLine(to: CGPoint(x: self.bounds.width - cor, y: cor))
    
        progresslayer.path = path.cgPath
        progresslayer.strokeEnd = 1
        layer.addSublayer(progresslayer)
        
    }
    
    func set(progress: CGFloat,
             lineCap: String? = kCALineCapRound,
             lineJoin: String? = kCALineJoinBevel,
             type: CapLine? = .capround) {
        
        self.progressStrokeEnd = progress
        if let lineCap = lineCap { progressLineCap = lineCap }
        if let lineJoin = lineJoin { progressLineJoin = lineJoin }
    }
    
    func draw() {
        
        progresslayer.lineCap = progressLineCap
        progresslayer.lineJoin = progressLineJoin
        progresslayer.strokeEnd = progressStrokeEnd
    }

}

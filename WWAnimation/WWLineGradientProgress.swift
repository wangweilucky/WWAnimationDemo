//
//  WWGradientProgress.swift
//  WWAnimation
//
//  Created by wangwei on 2018/9/6.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

enum CapLine {
    case capround
    case capbutt
}

class WWLineGradientProgress: UIView {
    
    var progressStrokeEnd: CGFloat = 0
    var gradientColors: [CGColor] = []
    var progressLocations: [NSNumber] = []
    var progressLineCap: String = ""
    var progressLineJoin: String = ""
    var progressType : CapLine = .capround
    
    lazy var conLayer: CALayer = {
        
        let conLayer = CALayer()
        conLayer.backgroundColor = UIColor.clear.cgColor
        conLayer.frame = self.bounds
        conLayer.cornerRadius = self.bounds.height * 0.5
        conLayer.masksToBounds = true
        return conLayer
    }()
    
    lazy var gradientLayer: CAGradientLayer = {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        return gradientLayer
    }()
    
    lazy var progresslayer: CAShapeLayer = {
        
        let progresslayer = CAShapeLayer()
        progresslayer.contentsScale = UIScreen.main.scale
        progresslayer.frame = self.bounds
        
        progresslayer.fillColor = UIColor.clear.cgColor
        progresslayer.strokeColor = UIColor.red.cgColor
        progresslayer.lineWidth = self.bounds.height // 设置线宽度
        
        let path = UIBezierPath()
        
        let cor = self.frame.height * 0.5
        
        path.move(to: CGPoint(x: cor, y: cor))
        path.addLine(to: CGPoint(x: self.bounds.width, y: cor))
        progresslayer.path = path.cgPath
        
        progresslayer.strokeEnd = 0
        return progresslayer
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
        
        layer.cornerRadius = self.bounds.height * 0.5
        layer.masksToBounds = true
        layer.addSublayer(conLayer)
        conLayer.addSublayer(gradientLayer)
        conLayer.mask = progresslayer
    }
    
    func set(colors: [CGColor],
             progress: CGFloat,
             locations: [NSNumber]? = nil,
             lineCap: String? = kCALineCapRound,
             lineJoin: String? = kCALineJoinBevel,
             type: CapLine? = .capround) {
        
        if let type1 = type           { progressType = type1}
        if let locations = locations { progressLocations = locations}
        if let lineCap   = lineCap     { progressLineCap   = lineCap}
        if let lineJoin  = lineJoin   { progressLineJoin  = lineJoin}
        if let lineJoin  = lineJoin   { progressLineJoin  = lineJoin}
        gradientColors   = colors
        progressStrokeEnd   = progress
        progresslayer.frame = CGRect(x: progresslayer.frame.origin.x,
                                     y: progresslayer.frame.origin.y,
                                     width: progresslayer.frame.width * progress,
                                     height: progresslayer.frame.height)
    }
    
    func draw() {
        
        gradientLayer.colors    = gradientColors
        progresslayer.lineJoin  = progressLineJoin
        progresslayer.lineCap   = progressLineCap
        progresslayer.strokeEnd = progressStrokeEnd
    }

}

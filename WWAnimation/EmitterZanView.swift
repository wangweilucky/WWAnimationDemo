//
//  EmitterZanView.swift
//  WWAnimation
//
//  Created by wangwei on 2018/9/4.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

class EmitterZanView: UIView {

    var emitterLayer = CAEmitterLayer()
    var emitterCells = [CAEmitterCell]()
    var animation = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initMyView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initMyView()
    }
    
    func initMyView() {
        
        let emitterCell = CAEmitterCell()
        emitterCell.name = "explosion"
        emitterCell.alphaRange = 0.2
        emitterCell.alphaSpeed = -1.0
        emitterCell.lifetime = 0.3
        emitterCell.lifetimeRange = 0.2
        emitterCell.birthRate = 0
        emitterCell.velocity = 40
        emitterCell.velocityRange = 10.0
        emitterCell.scale = 0.5
        emitterCell.scaleRange = 0.2
        emitterCell.emissionLongitude = CGFloat(-Double.pi * 0.5)
        emitterCell.emissionRange = CGFloat(Double.pi * 0.25)
        emitterCell.contents = UIImage(named: "Shape")!.cgImage
        emitterLayer.name = "emitterLayer"
        emitterLayer.emitterShape = kCAEmitterLayerCircle
        /*kCAEmitterLayerPoint: kCAEmitterLayerLine: kCAEmitterLayerRectangle: kCAEmitterLayerCuboid:
         kCAEmitterLayerCircle: kCAEmitterLayerSphere: */
        emitterLayer.emitterMode = kCAEmitterLayerOutline
        emitterLayer.emitterPosition = CGPoint(x: self.layer.bounds.midX, y: self.layer.bounds.midY)
        emitterLayer.emitterSize = CGSize(width: 25, height: 0)
        emitterLayer.emitterCells = [emitterCell]
        emitterLayer.renderMode = kCAEmitterLayerOldestFirst
        self.layer.addSublayer(emitterLayer)
        
        emitterCells = [emitterCell];
        
    }
    
    func startAnimate() {
        if animation {return}
        animation = true
        self.perform(#selector(explode), with: nil, afterDelay: 0.2)
    }
    
    @objc func explode() {
        emitterLayer.beginTime = CACurrentMediaTime()
        emitterLayer.setValue(500, forKeyPath: "emitterCells.explosion.birthRate")
        perform(#selector(stop), with: nil, afterDelay: 0.1)
    }
    
    @objc func stop() {
        animation = false
        emitterLayer.setValue(0, forKeyPath: "emitterCells.explosion.birthRate")
    }
    
    

}

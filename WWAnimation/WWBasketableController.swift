//
//  WWBasketableController.swift
//  WWAnimation
//
//  Created by wangwei on 2018/9/19.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

class WWBasketableController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.运动轨迹，可以使用贝塞尔曲线绘画出对应的path
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 10, y: 350))
        path.addCurve(to: CGPoint(x: 350, y: 400),
                      controlPoint1: CGPoint(x: 120, y: 10),
                      controlPoint2: CGPoint(x: 300, y: 20))
        let pathLayer = CAShapeLayer()
        pathLayer.lineWidth = 4.0
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.strokeColor = UIColor.red.cgColor
        pathLayer.path = path.cgPath
        pathLayer.frame = view.layer.bounds
        view.layer.addSublayer(pathLayer)
        
        // 2.球可以制定成一张图片
        let imageV = UIImageView(image: UIImage(named: "篮球"))
        imageV.frame.size = CGSize(width: 40, height: 40)
        view.layer.addSublayer(imageV.layer)
        
        // 3.添加path到CAKeyFrameAnimation中，实现球沿着path运动
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = 3.0
        let timingFunc = CAMediaTimingFunction(controlPoints: 0.10, 0.50, 0.90, 0.50)
        animation.timingFunction = timingFunc
        animation.autoreverses = false
        animation.repeatCount = HUGE
        animation.path = path.cgPath
        imageV.layer.add(animation, forKey: "imagePosition")
        
        
        
        // 1.运动轨迹，可以使用贝塞尔曲线绘画出对应的path
        let pathA = UIBezierPath()
        pathA.move(to: CGPoint(x: 10, y: 700))
        pathA.addCurve(to: CGPoint(x: 100, y: 700),
                      controlPoint1: CGPoint(x: 40, y: 310),
                      controlPoint2: CGPoint(x: 60, y: 320))
        
        pathA.move(to: CGPoint(x: 100, y: 700))
        pathA.addCurve(to: CGPoint(x: 150, y: 700),
                       controlPoint1: CGPoint(x: 120, y: 410),
                       controlPoint2: CGPoint(x: 135, y: 420))
        
        pathA.move(to: CGPoint(x: 150, y: 700))
        pathA.addCurve(to: CGPoint(x: 200, y: 700),
                       controlPoint1: CGPoint(x: 166, y: 510),
                       controlPoint2: CGPoint(x: 185, y: 520))
        
        pathA.move(to: CGPoint(x: 200, y: 700))
        pathA.addCurve(to: CGPoint(x: 260, y: 700),
                       controlPoint1: CGPoint(x: 220, y: 610),
                       controlPoint2: CGPoint(x: 245, y: 620))
        
        pathA.move(to: CGPoint(x: 260, y: 700))
        pathA.addCurve(to: CGPoint(x: 300, y: 700),
                       controlPoint1: CGPoint(x: 270, y: 630),
                       controlPoint2: CGPoint(x: 290, y: 640))
        
        pathA.move(to: CGPoint(x: 300, y: 700))
        pathA.addCurve(to: CGPoint(x: 340, y: 700),
                       controlPoint1: CGPoint(x: 315, y: 650),
                       controlPoint2: CGPoint(x: 330, y: 660))
        
        let pathLayerA = CAShapeLayer()
        pathLayerA.lineWidth = 4.0
        pathLayerA.fillColor = UIColor.clear.cgColor
        pathLayerA.strokeColor = UIColor.red.cgColor
        pathLayerA.path = pathA.cgPath
        pathLayerA.frame = view.layer.bounds
        view.layer.addSublayer(pathLayerA)
        
        // 2.球可以制定成一张图片
        let imageVA = UIImageView(image: UIImage(named: "篮球"))
        imageVA.frame.size = CGSize(width: 40, height: 40)
        view.layer.addSublayer(imageVA.layer)
        
        // 3.添加path到CAKeyFrameAnimation中，实现球沿着path运动
        let pathB = UIBezierPath()
        pathB.move(to: CGPoint(x: 10, y: 700))
        pathB.addCurve(to: CGPoint(x: 100, y: 700),
                       controlPoint1: CGPoint(x: 40, y: 310),
                       controlPoint2: CGPoint(x: 60, y: 320))
        
        let pathC = UIBezierPath()
        pathC.move(to: CGPoint(x: 100, y: 700))
        pathC.addCurve(to: CGPoint(x: 150, y: 700),
                       controlPoint1: CGPoint(x: 120, y: 410),
                       controlPoint2: CGPoint(x: 135, y: 420))
        
        let pathD = UIBezierPath()
        pathD.move(to: CGPoint(x: 150, y: 700))
        pathD.addCurve(to: CGPoint(x: 200, y: 700),
                       controlPoint1: CGPoint(x: 166, y: 510),
                       controlPoint2: CGPoint(x: 185, y: 520))
        
        let pathE = UIBezierPath()
        pathE.move(to: CGPoint(x: 200, y: 700))
        pathE.addCurve(to: CGPoint(x: 260, y: 700),
                       controlPoint1: CGPoint(x: 220, y: 610),
                       controlPoint2: CGPoint(x: 245, y: 620))
        
        let pathF = UIBezierPath()
        pathF.move(to: CGPoint(x: 260, y: 700))
        pathF.addCurve(to: CGPoint(x: 300, y: 700),
                       controlPoint1: CGPoint(x: 270, y: 630),
                       controlPoint2: CGPoint(x: 290, y: 640))
        
        let pathG = UIBezierPath()
        pathG.move(to: CGPoint(x: 300, y: 700))
        pathG.addCurve(to: CGPoint(x: 340, y: 700),
                       controlPoint1: CGPoint(x: 315, y: 650),
                       controlPoint2: CGPoint(x: 330, y: 660))
        
        let animationA = CAKeyframeAnimation(keyPath: "position")
        animationA.timingFunction = timingFunc
        animationA.path = pathA.cgPath
        animationA.values = [pathB, pathC, pathD, pathE, pathF, pathG]
        animationA.keyTimes = [0.25, 0.44, 0.65, 0.75, 0.88, 1.0]
        animationA.timingFunctions = [timingFunc, timingFunc, timingFunc, timingFunc, timingFunc]
        
        let animationB = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        animationB.values =   [0, Float.pi * 2, Float.pi * 4, Float.pi * 6 ,Float.pi * 8]
        animationA.keyTimes = [0.25, 0.44, 0.65, 0.75, 0.88, 1.0]
        animationA.timingFunctions = [timingFunc, timingFunc, timingFunc, timingFunc, timingFunc]
        
        let animationG = CAAnimationGroup()
        animationG.animations = [animationA, animationB]
        animationG.duration = 5.0
        animationG.autoreverses = false
        animationG.repeatCount = HUGE
        
        imageVA.layer.add(animationG, forKey: "imagePositionA")
        
    }

}

//
//  MWBezierCurveView.swift
//  BezierCurveView
//
//  Created by 王大吉 on 18/4/2018.
//  Copyright © 2018 王大吉. All rights reserved.
//

import UIKit

// 线条类型： 曲线、折线
enum BezierSmoothLine {
    case smooth
    case grid
}

// 线条类型： 实线、虚线
enum BezierSolidLine {
    case solid
    case dotted
}

// 线条动画： 线性、inout、
enum BezierAnimation {
    case line
}

// 坐标网格图层
enum BezierReplicator {
    case line
    case noLine
}

class MWBezierCurveView: UIView {

    var colors: [UIColor] = [UIColor.red]
    
    var smoothType: BezierSmoothLine = .grid
    var solidType: BezierSolidLine = .dotted
    
    /// x轴名称、y轴的刻度
    var x_names = Array<String>()
    var y_targetValues = Array<CGFloat>()
    
    /// x轴左右间距
    var xPadding : CGFloat = 20
    
    /// y轴上间距
    var yTopPadding : CGFloat = 30
    
    /// y轴下间距
    var yBottomPadding : CGFloat = 30
    
    /// x轴的每个间距
    var xMargin : CGFloat = 0
    
    /// y轴的每一个刻度的距离
    var yMarginRatio : CGFloat = 0
    
    /// 所有的坐标
    var allPoints = [CGPoint]()
    
    var leftMargin : CGFloat = 0
    var bottomMargin : CGFloat = 40
    
    /// 所有的值中的最小值
    var minY: CGFloat = 0
    
    /// 显示的高度
    var selfHeight: CGFloat {
        return self.frame.height - yBottomPadding - yTopPadding
    }
    
    
    // 先假定原点坐标：（self.frame.height-20, 20）
    var y_margin = 15
    
    func draylineChartView(x_names: Array<String>,
                           y_targetValues: Array<CGFloat>,
                           colors: Array<UIColor>) {
        
        self.x_names = x_names
        self.y_targetValues = y_targetValues
        self.colors = colors
        
        // x轴的间距
        self.xMargin = (self.frame.width - xPadding * 2) / CGFloat(x_names.count - 1)
        
        // y轴的比例
        yMarginRatio = getYMarginRatio1()
        
        // 获取所有坐标
        allPoints = getAllPoints()
        
        /// 画横坐标
        drawHengzuobiao()
        
        // 将坐标连线
        drawdotWithLine()
        
        // 添加目标值文字
        drawdotTitle()
    }
    
}


extension MWBezierCurveView {
    
    /// 显示点对应的数值
    func drawdotTitle() {
        for (_, _) in allPoints.enumerated() {
            
//            let titleL = UILabel()
//            titleL.text = "\(y_targetValues[index])"
//            self.addSubview(titleL)
//            titleL.textColor = UIColor.white
//            titleL.font = UIFont.systemFont(ofSize: 10)
//            titleL.snp.makeConstraints { make in
//                make.centerX.equalTo(allPoints[index].x)
//                make.top.equalTo(allPoints[index].y - 20)
//            }
        }
    }
    
    /// 将坐标点连线
    func drawdotWithLine() {
        
        if allPoints.count <= 0 {return}
        var prePoint = allPoints.first!
        
        let path = UIBezierPath()
        
        let gradientPath = UIBezierPath()
        let gradientLayer = CAShapeLayer()
        var fullPath = UIBezierPath()
        
        // 画网格
//        let rowReplicatorLayer = CAReplicatorLayer()
//        rowReplicatorLayer.position = CGPoint(x: 0, y: 0)
//        self.layer.addSublayer(rowReplicatorLayer)
//
//        let lowReplicatorLayer = CAReplicatorLayer()
//        lowReplicatorLayer.position = CGPoint(x: 0, y: 0)
//        self.layer.addSublayer(lowReplicatorLayer)
        
        // 画线
        for item in allPoints {
            
            path.move(to: prePoint)
            
            let nowPoint = item
            
            switch smoothType {
            case .grid:
                path.addLine(to: nowPoint)
            case .smooth:
                path.addCurve(to: nowPoint,
                              controlPoint1: CGPoint(x: (prePoint.x + nowPoint.x) * 0.5, y: prePoint.y),
                              controlPoint2: CGPoint(x: (prePoint.x + nowPoint.x) * 0.5, y: nowPoint.y))
            }
            
            prePoint = item
        }
        
        // 完整的图层
        if allPoints.count > 1 {
            
            fullPath = path.copy() as! UIBezierPath
            fullPath.addLine(to: CGPoint(x: allPoints.last!.x,  y: (selfHeight + yTopPadding)))
            fullPath.addLine(to: CGPoint(x: allPoints.first!.x, y: (selfHeight + yTopPadding)))
            fullPath.addLine(to: CGPoint(x: allPoints.first!.x, y: allPoints.first!.y))
            
            let fullPathLayer = CAShapeLayer()
            self.layer.addSublayer(fullPathLayer)
            fullPathLayer.path = fullPath.cgPath
            fullPathLayer.lineCap = kCALineCapSquare
//            fullPathLayer.fillColor = UIColor.blue.cgColor
            fullPathLayer.strokeColor = UIColor.blue.cgColor
            
            let fullPathLayerAnimation = CABasicAnimation(keyPath: "strokeEnd")
            fullPathLayerAnimation.fromValue = 0.0
            fullPathLayerAnimation.toValue = 1.0
            fullPathLayerAnimation.duration = 2.0
            fullPathLayer.add(fullPathLayerAnimation, forKey: "fullPathLayerAnimation")
            
//            let gradientLayer = CALayer()
//            gradientLayer.frame = self.bounds
//            gradientLayer.backgroundColor = UIColor.black.cgColor
//            fullPathLayer.mask = gradientLayer
        }
        
        // 渐变层
//        gradientPath.
//        if allPoints.count > 1 {
//            gradientPath.addLine(to: CGPoint(x: allPoints.last!.y, y: 0))
//            fullPath.addLine(to: CGPoint(x: allPoints.first!.x, y: 0))
//            fullPath.addLine(to: CGPoint(x: allPoints.first!.x, y: allPoints.first!.y))
//        }
        
        /// 画曲线
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.borderWidth = 2.0
        self.layer.addSublayer(layer)
        switch solidType {
        case .dotted:
            //设置虚线的线宽及间距
            layer.lineDashPattern = [NSNumber(value: 10)]
        case .solid:
            break
        }
        
        
        
        /// 给曲线加动画
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 0.8
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue = 1.0
        pathAnimation.autoreverses = false
        layer.add(pathAnimation, forKey: "strokeEndAinmation")
        
//        for (index, _) in allPoints.enumerated() {
//            if index == 0 {}
//            else {
//
//                let path = UIBezierPath()
//
//                path.move(to: prePoint)
//
//                let nowPoint = allPoints[index]
//
//                path.addCurve(to: nowPoint,
//                              controlPoint1: CGPoint(x: (prePoint.x + nowPoint.x) * 0.5, y: prePoint.y),
//                              controlPoint2: CGPoint(x: (prePoint.x + nowPoint.x) * 0.5, y: nowPoint.y))
//
//                /// 画曲线
//                let layer = CAShapeLayer()
//                layer.path = path.cgPath
//                layer.strokeColor = UIColor.black.cgColor
//                layer.fillColor = UIColor.clear.cgColor
//                layer.borderWidth = 2.0
//
//                /// 给曲线加动画
//                let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
//                pathAnimation.duration = 0.8
//                pathAnimation.fromValue = 0.0
//                pathAnimation.toValue = 1.0
//                pathAnimation.autoreverses = false
//                layer.add(pathAnimation, forKey: "strokeEndAinmation")
//                self.layer.addSublayer(layer)
                
//                let gradientLayer = CAGradientLayer()
//                gradientLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
//                gradientLayer.colors = getLineColor(index: index)
//                gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//                gradientLayer.endPoint = CGPoint(x: 0, y: 1.0)
//                gradientLayer.locations = [NSNumber(value: 0.0), NSNumber(value: 1.0)]
//                layer.addSublayer(gradientLayer)
                
//                let baseLayer = CALayer()
//                baseLayer.addSublayer(gradientLayer)
//                baseLayer.mask = layer
//                self.layer.addSublayer(baseLayer)
//
//                /// 渐变阴影
//                path.addLine(to: CGPoint(x: nowPoint.x, y: (selfHeight + yTopPadding)))
//                path.addLine(to: CGPoint(x: prePoint.x, y: (selfHeight + yTopPadding)))
//                path.addLine(to: prePoint)
//                let shapeLayer = CAShapeLayer()
//                shapeLayer.path = path.cgPath
//                shapeLayer.strokeColor = UIColor.white.cgColor
//                shapeLayer.fillColor = UIColor.white.cgColor
//                shapeLayer.borderWidth = 2.0
//                self.layer.addSublayer(shapeLayer)
//
//                let graL = CAGradientLayer()
//                graL.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
//                graL.colors = [colors.first!, UIColor.white.withAlphaComponent(0).cgColor]
//                graL.startPoint = CGPoint(x: 0, y: 0)
//                graL.endPoint = CGPoint(x: 1, y: 1)
////                graL.locations = [NSNumber(value: 0.1), NSNumber(value: 1.0)]
//                self.layer.addSublayer(graL)
//                let baseLayer1 = CALayer()
//                baseLayer1.addSublayer(graL)
//
//                baseLayer1.mask = shapeLayer
//
////                self.layer.add(pathAnimation, forKey: "11")
//                self.layer.addSublayer(baseLayer1)
                
//                 prePoint = nowPoint
//            }
//        }
    }
    
    /// 获取所有坐标
    func getAllPoints() -> [CGPoint] {
        
        let r: CGFloat = 3.0
        
        var allPoints = [CGPoint]()
        
        for (index, item) in y_targetValues.enumerated() {
            let x = xPadding + xMargin * CGFloat(index)
            let y = (selfHeight - yMarginRatio * item + yMarginRatio * minY) + yTopPadding
//            let y = (selfHeight - yMarginRatio * item) + yTopPadding
            let point = CGPoint(x: x, y: y)
            let path = UIBezierPath(roundedRect: CGRect(x: x-r, y: y-r, width: r*2, height: r * 2), cornerRadius: 6)
            let layer = CAShapeLayer()
            layer.path = path.cgPath
            layer.strokeColor = getdotColor(index: index)
            layer.fillColor = getdotColor(index: index)
            self.layer.addSublayer(layer)
            allPoints.append(point)
        }
        return allPoints
    }
    
    /// y轴的每一个刻度比例
    func getYMarginRatio1() -> CGFloat {
        var maxY : CGFloat = 0
        var minY : CGFloat = 0
        for item in y_targetValues {
            if item > maxY { maxY = item }
            if item < minY { minY = item }
        }
        let distance = (maxY - minY)
        self.minY = minY
        return (distance == 0 ? 0 : selfHeight/distance)
    }
    
    /// 画x横坐标
    func drawHengzuobiao() {
        // 横坐标
        for (index, itemPoint) in allPoints.enumerated() {
            let x = itemPoint.x
            let y = selfHeight + yTopPadding
            
            // 坐标点
            let point = CGPoint(x: x, y: y)
            let path = UIBezierPath(roundedRect: CGRect(x: x-1.0, y: y-1.0, width: 2.5, height: 2.5), cornerRadius: 2.5)
            let layer = CAShapeLayer()
            layer.path = path.cgPath
            layer.strokeColor = UIColor.white.cgColor
            layer.fillColor = UIColor.white.cgColor
            self.layer.addSublayer(layer)
            
            let linePath = UIBezierPath()
            let lineLayer = CAShapeLayer()
            linePath.move(to: point)
            linePath.addLine(to: itemPoint)
            lineLayer.path = linePath.cgPath
            lineLayer.lineWidth = 0.1;
            lineLayer.strokeColor = UIColor.white.cgColor;
            lineLayer.path = linePath.cgPath;
            lineLayer.fillColor = UIColor.white.cgColor; // 默认为blackColor
            self.layer.addSublayer(lineLayer)
            
            let titleL = UILabel()
            titleL.text = x_names[index]
            self.addSubview(titleL)
            titleL.textColor = UIColor.white
            titleL.font = UIFont.systemFont(ofSize: 10)
//            titleL.snp.makeConstraints { make in
//                make.centerX.equalTo(allPoints[index].x)
//                make.top.equalTo(selfHeight + 4 + yTopPadding)
//            }
        }
    }
    
    
    /// 渐变阴影
    func drawGradient(bezier: UIBezierPath) {
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezier.cgPath
        shapeLayer.fillColor = UIColor.red.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        gradientLayer.colors = [colors.first!, colors.first!]
        gradientLayer.cornerRadius = 5
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.locations = [NSNumber(value: 0.0), NSNumber(value: 1.0)]
        
        let baseLayer = CALayer()
        baseLayer.addSublayer(gradientLayer)
        baseLayer.mask = shapeLayer
//        self.layer.insertSublayer(baseLayer, at: 0)
        self.layer.addSublayer(baseLayer)
        
    }
    
    // 根据index获取当前点的颜色
    func getdotColor(index: Int) -> CGColor {
        switch index {
        case 0:
            return colors.first!.cgColor
        case 1:
            return colors.first!.cgColor
        case 2:
            return colors.first!.cgColor
        case 3:
            return colors.first!.cgColor
        default:
            return colors.first!.cgColor
        }
    }
    
    
    // 根据index获取线段的颜色
    func getLineColor(index: Int) -> [CGColor] {
        switch index {
            
        case 1:
            return [colors.first!.cgColor, colors.first!.cgColor]
        case 2:
            return [colors.first!.cgColor, colors.first!.cgColor]
        case 3:
            return [colors.first!.cgColor, colors.first!.cgColor]
        case 4:
            return [colors.first!.cgColor, colors.first!.cgColor]
        default:
            return [colors.first!.cgColor, colors.first!.cgColor]
        }
    }
}

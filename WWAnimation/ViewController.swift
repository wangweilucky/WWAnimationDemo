//
//  ViewController.swift
//  WWAnimation
//
//  Created by 王大吉 on 28/8/18.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var zanView: EmitterZanView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var curveView: MWBezierCurveView!
    var progressAniView: WWProgressAnimatedView?
    var timer :Timer?
  
    @IBOutlet weak var lineProgressBar: WWLineProgress!
    @IBOutlet weak var lineGradientprogressBar: WWLineGradientProgress!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.zanView.startAnimate()
        
        let animationView = WWIndefiniteAnimatedView(frame: contentView.bounds)
        contentView.addSubview(animationView)
        
        let progressAniView = WWProgressAnimatedView(frame: contentView.bounds)
        progressView.addSubview(progressAniView)
        self.progressAniView = progressAniView
        
//        timer = Timer(timeInterval: 1, repeats: true, block: { _ in
//            self.progressAniView.set(progress: self.progressAniView.strokeEnd + 0.1)
//        })
        RunLoop.main.add(timer!, forMode: .commonModes)
        
        
        curveView.draylineChartView(x_names: ["1", "2", "3", "4", "5", "6"],
                                    y_targetValues: [5, 70, 120, 50, 100, 88],
                                    colors: [UIColor.red])
    
        lineGradientprogressBar.set(colors: [UIColor.orange.cgColor, UIColor.red.cgColor], progress: CGFloat(drand48()))
        lineGradientprogressBar.draw()
        lineProgressBar.set(progress: CGFloat(drand48()))
        lineProgressBar.draw()
    }

}


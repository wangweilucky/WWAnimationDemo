//
//  WWLoadingController.swift
//  WWAnimation
//
//  Created by wangwei on 2018/9/7.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

class WWLoadingController: UIViewController {

    var timer :Timer?
    var radarViewAnimation = true
    
    @IBOutlet weak var indefiniteAnimatedView: WWIndefiniteAnimatedView!
    @IBOutlet weak var progressAnimatedView: WWProgressAnimatedView!
    @IBOutlet weak var radarView: WWRadarView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        timer = Timer(timeInterval: 0.4, repeats: true, block: { _ in
            self.progressAnimatedView.set(progress: self.progressAnimatedView.progressAnimatedLayer.strokeEnd + 0.1)
            if self.progressAnimatedView.progressAnimatedLayer.strokeEnd >= 1.0  {self.progressAnimatedView.progressAnimatedLayer.strokeEnd = 0}
        })
        RunLoop.main.add(timer!, forMode: .commonModes)
     
        showRadarView()// 雷达
        
    }
    
    
    func showRadarView() {
        
        radarView.startAnimation()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            self.radarView.stopAnimation()
            self.radarViewAnimation = !self.radarViewAnimation
            self.showRadarView()
        }
        
    }

}

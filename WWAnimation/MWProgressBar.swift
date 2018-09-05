//
//  MWProgressBar.swift
//  VietNews
//
//  Created by wangwei on 2018/9/5.
//  Copyright © 2018年 cafei. All rights reserved.
//

import UIKit

class MWProgressBar: UIView {

    @IBOutlet weak var processView: UIProgressView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let view = UINib(nibName: "MWProgressBar", bundle: nil).instantiate(withOwner: self, options: nil).last as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func set(process: Float)  {
        processView.layer.cornerRadius = processView.frame.height * 0.5
        processView.layer.masksToBounds = true
        processView.setProgress(process, animated: true)
    }
}

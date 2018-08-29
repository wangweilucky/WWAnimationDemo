//
//  ViewController.swift
//  WWAnimation
//
//  Created by 王大吉 on 28/8/18.
//  Copyright © 2018年 王大吉. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let animationView = WWIndefiniteAnimatedView(frame: contentView.bounds)
        contentView.addSubview(animationView)
    }

}


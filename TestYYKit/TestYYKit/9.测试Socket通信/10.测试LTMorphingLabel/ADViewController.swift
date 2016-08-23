//
//  ADViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/8/23.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import Kingfisher

class ADViewController: UIViewController {
    
    private lazy var adImageView: UIImageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(adImageView)
        
        /// 让开场动画飞起来
        adImageView.image = UIImage(named: "10")
        flyAimation()
        /// 广告页面
//       let time = NSTimer(timeInterval: 3.0, target: self, selector:#selector(self.changeController), userInfo: nil, repeats: false)
//        NSRunLoop.currentRunLoop().addTimer(time, forMode: NSRunLoopCommonModes)
    }

    func flyAimation() {
        UIView.animateWithDuration(0.5, animations: {
            self.adImageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 50, height: 50))
            self.adImageView.center = self.view.center
        }) { (flag) in
            UIView.animateWithDuration(0.8, animations: {
                self.adImageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 5000, height: 5000))
                self.adImageView.center = self.view.center
                }, completion: { (flag) in
                    self.changeController()
            })
        }
    }
    func changeController() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Navi")
        
        UIApplication.sharedApplication().keyWindow?.rootViewController = vc
    }

}

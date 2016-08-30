//
//  RACSubjectViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/8/30.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import ReactiveCocoa

class RACSubjectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // RACSubject:信号提供者
        //1.创建信号 
        let subject = RACSubject()
        //2.订阅信号
        subject.subscribeNext { (x) in
            // block:当有数据发出的时候就会调用
            // block:处理数据
            print(x)
        }
        // 3.发送信号
        subject.sendNext(1)
        
        // 开发中，使用这个RACSubject代替代理
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnClick(sender: AnyObject) {
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("two") as? TwoViewController
//        guard let vcc = vc else { return }
//        vcc.subject = RACSubject()
//        vcc.subject?.subscribeNext({ (x) in
//            print("通知了ViewController")
//        })
//        presentViewController(vcc, animated: true, completion: nil)
      // 1.创建信号
        let subject = RACReplaySubject()
        //2.订阅信号 
        subject.subscribeNext { (x) in
            print("第一个订阅者\(x)")
        }
        subject.subscribeNext { (x) in
            print("第二个订阅者\(x)")
        }
        //3. 发送信号 
        subject.sendNext(1)
        subject.sendNext(2)
    
    }


}

//
//  RACMultiConectionViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/8/30.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import ReactiveCocoa

class RACMultiConectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let signal = RACSignal.createSignal { (subcriber) -> RACDisposable! in
            print("发送请求")
            subcriber.sendNext(1)
            return nil
        }
        // 订阅信号
        signal.subscribeNext { (x) in
            print(x)
        }
        // 1.创建连接类
        let connection = signal.publish()
        // 2.订阅信号
        connection.signal.subscribeNext { (x) in
            print(x)
        }
        connection.signal.subscribeNext { (x) in
            print(x)
        }
        connection.signal.subscribeNext { (x) in
            print(x)
        }
        // 3.连接：才会吧源信号变成热信号
        connection.connect()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

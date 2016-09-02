//
//  RACViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/8/30.
//  Copyright © 2016年 lieon. All rights reserved.
//
// swiftlint:disable trailing_whitespace

import UIKit
import ReactiveCocoa

class RACViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
   
    // 核心:信号类
        /**
         信号类的作用：只要有数据改变，就会把数据包装成一个信号，传递出去
         只要有数据改变，就会用有信号发出
         数据发出，并不是信号类发出
         
         1.创建信号: createSignal:didSubscribe(block)
          RACDisposable:取消订阅
          RACSubscriber:发送数据
         
          createSignal方法:
         1.创建RACDynamicSignal
         2.把didSubscribe保存到RACDynamicSignal
         */
        let signal = RACSignal.createSignal { (subscriber) -> RACDisposable! in
            /**
             bloc调用时刻：当信号被订阅时就会调用 
             block作用：描述当前信号哪些数据需要发送
             */
            // 发送数据
            print("调用了didSubcribe")
            // 通常传递数据出去
            // 调用者的nextBlock
            subscriber.sendNext(1)
            // 如果信号，想要取消，就必须返回一个RACDisposable
            return RACDisposable(block: { 
                print("取消订阅")
                // 信号什么时候被取消：1.自动取消，当一个信号的订阅者被撤毁的时自动被取消订阅，2.主动取消 
                // block调用时刻:一旦一个信号，被取消订阅的时候就会被调用
                //  block作用：当信号取消订阅，用于清空一些资源
            })
        }
        
        /**
         subscribeNext:
         1.创建订阅者
         2.把nextBlock保存到订阅者里面
         订阅信号 
         只要订阅信号，就会返回一个取消订阅信号的类
         */
        _ = signal.subscribeNext { (x) in
           // block :只要信号内部发送数据，就会调用这个block
            print(x)
        }
        /**
         RACSignal使用步骤:
         1.创建信号
         2.订阅信号
         RACSingal底层实现：
         1.当一个信号被订阅，创建订阅者，并且把nextBlock保存到订阅者里面
          2.[RACDynamicSignal subscribe:RACSubscriber]
         3.调用RACDynamicSignal的didSubscribe
         4.[subscriber sendNext:@1];
         5.拿到订阅者的nextBlock调用
         */
        
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

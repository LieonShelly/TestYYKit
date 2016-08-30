//
//  RACCommandViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/8/30.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import ReactiveCocoa

class RACCommandViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 使用注意点：RACCommand中的block不能返回一个nil
        let command = RACCommand { (input) -> RACSignal! in
            // block什么时候调用:当执行这个命令类的时候就会调用
            print("执行命令\(input)")
            // block有什么作用:描述下如何处理事件，网络请求
         // 为什么RACCommand必须返回信号，因为处理事件的时候，肯定会有数据产生，产生的数据就通过返回的信号发出
            return RACSignal.createSignal({ (subcriber) -> RACDisposable! in
                // block作用：发送处理事件的信号
                // block调用：当信号被订阅的时候才会调用
                subcriber.sendNext("信号发出的内容")
                return nil
            })
        }
        // _command = command;
        // executionSignals:信号源，包含事件处理的所有信号。
        // executionSignals: signalOfSignals,什么是信号中的信号，就是信号发出的数据也是信号类
        
        // 如果想要接收信号源的信号内容，必须保证命令类不会被销毁
        command.executionSignals.subscribeNext { (x) in
            if let singnal = x as? RACSignal {
                singnal.subscribeNext({ (x) in
                    print(x)
                })
            }
            
        }
        // 执行命令,调用signalBlock
        command.execute(1)
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

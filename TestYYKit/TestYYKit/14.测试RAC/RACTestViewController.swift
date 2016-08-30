//
//  RACTestViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/8/30.
//  Copyright © 2016年 lieon. All rights reserved.
//  RAC的常见用法

import UIKit
import ReactiveCocoa

class RACTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 创建热门商品的信号
        let signalA = RACSignal.createSignal { (subcriber) -> RACDisposable! in
            //  处理信号  
            print("请求热门信号")
            subcriber.sendNext("热门商品")
            return nil
        }
        let signalB = RACSignal.createSignal { (subcriber) -> RACDisposable! in
            // 处理信号
            print("请求最新商品")
            // 发送数据
            subcriber.sendNext("最新商品")
            return nil
        }
        /**
         RAC：就可以判断两个信号有没有都发出内容
         SignalsFromArray:监听哪些信号的发出
         当signals数组中的所有信号都发送sendNext就会触发方法调用者（self的selector）
         注意：selector方法的参数不能乱写,有几个信号就对应几个参数
         不需要主动订阅signalA,signalB,方法内部会自动订阅
         */
        rac_liftSelector(#selector(self.updateUIWithHot), withSignalsFromArray: [signalA,signalB])
    }

    func updateUIWithHot() {
        
    }
    /**
     *  1.RAC替换代理
     */
    func delegate() {
        // 1.RAC替换代理
        // RAC:判断下一个方法有没有调用,如果调用了就会自动发送一个信号给你
        
        // 只要self调用viewDidLoad就会转换成一个信号
        // 监听_redView有没有调用btnClick:,如果调用了就会转换成信号
        let redView = RedView()
        redView.rac_signalForSelector(#selector(RedView.btnClick)).subscribeNext { (x) in
            print("控制器知道,点击了红色的view")
        }
        
    }
 
    /// 2.RAC充当KVO
    func KVO() {
        rac_valuesForKeyPath("age", observer: nil).subscribeNext { (x) in
           // block:只要属性改变就会调用,并且把改变的值传递给你
            print(x)
        }
    }
    
    /// 3.监听事件
    func event() {
        let btn = UIButton()
        btn.rac_signalForControlEvents(.TouchUpInside).subscribeNext { (x) in
            print("点击了按钮")
        }
        
    }
   
    /// 4.监听通知
    /// 只要发出这个通知，又会转换成一个信号
    func notification() {
        NSNotificationCenter.defaultCenter().rac_addObserverForName(UIKeyboardWillShowNotification, object: nil).subscribeNext { (x) in
            print("弹出键盘")
        }
    }
    
    /// 5.监听文本框的文字的改变
    func textChage() {
        let textfield = UITextField()
        textfield.rac_textSignal().subscribeNext { (x) in
            print(x)
        }
        
    }

}


class RedView: UIView {
   
    func btnClick(){
        
    }
}
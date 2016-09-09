//
//  RACGitHubViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/9/8.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import ReactiveCocoa

class RACGitHubViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /// 流和序列
        let array = [1, 2, 3, 4]
        /// 将数组转换为为流 -> 转化为数组
       _ = array.map { (value) -> Int in
            return value  * 2
        }
        setupUI()
    }
    
    private func setupUI() {
        let textField = UITextField()
        textField.borderStyle = .RoundedRect
        view.addSubview(textField)
        let btn = UIButton()
        btn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btn.setTitle("login", forState: UIControlState.Normal)
        view.addSubview(btn)
        btn.snp_makeConstraints { (make) in
            make.top.equalTo(textField.snp_bottom).inset(-10)
            make.centerX.equalTo(textField.snp_centerX)
            make.width.equalTo(55)
            make.height.equalTo(35)
        }
        textField.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(64)
            make.height.equalTo(44)
        }
        textField.rac_textSignal().subscribeNext({ (x) in
            print(x)
        })
        let vaildEmimalSignal =  textField.rac_textSignal().map { (text) -> AnyObject in
            guard let str = text as? String else { return false }
            return str.characters.contains("@")
        }
        btn.rac_command = RACCommand(enabled: vaildEmimalSignal, signalBlock: { (input) -> RACSignal! in
            print("btn clciked")
            return RACSignal.empty()
        })
    }
}

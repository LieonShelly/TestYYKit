//
//  ViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/7/25.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import YYKit
import SnapKit
import SVProgressHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
    }

   private func setupLabel()
    {
        let text = NSMutableAttributedString()
        let one = NSMutableAttributedString(string: "shsdfdfdfdfadow")
        one.font = UIFont.boldSystemFontOfSize(17)
        one.color = UIColor.blackColor()
        let shadow = YYTextShadow()
         shadow.color = UIColor.init(white: 0.000, alpha: 0.490)
         shadow.offset = CGSizeMake(0, 1)
         shadow.radius = 5
        one.textShadow = shadow
        text.appendAttributedString(one)
        view.addSubview(label)
        let two = NSMutableAttributedString(string: "https://www.baidu.com")
        two.font = UIFont.systemFontOfSize(17)
        two.underlineStyle = NSUnderlineStyle.StyleSingle
        
        two.setTextHighlightRange(two.rangeOfAll(), color: UIColor.blueColor(), backgroundColor: UIColor.blackColor()) { (_, string, _, _) in
            SVProgressHUD.showInfoWithStatus(two.string)
        }
 
        
        text.appendAttributedString(two)
        label.attributedText = text
        
        label.textAlignment = NSTextAlignment.Center
        label.textVerticalAlignment = YYTextVerticalAlignment.Center
        label.snp_makeConstraints { (make) in
            make.center.equalTo(view.snp_center)
            make.width.equalTo(view.snp_width)
            make.height.equalTo(view.snp_height)
        }
        


   }

    private func padding() -> NSMutableAttributedString
    {
        let padding = NSMutableAttributedString(string: "\n\n")
        padding.font = UIFont.systemFontOfSize(4)
        return padding
        
    }
   
    private lazy var label:YYLabel = {
        let label = YYLabel()
        label.backgroundColor = UIColor.init(white: 0.9333, alpha: 1.0)
        label.numberOfLines = 0
        
        return label
    }()
 
}


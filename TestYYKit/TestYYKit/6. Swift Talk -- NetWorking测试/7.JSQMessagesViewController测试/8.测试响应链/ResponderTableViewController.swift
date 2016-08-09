//
//  TableViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/8/9.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class ResponderTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      tableView.registerClass(ResponderCell.self, forCellReuseIdentifier: "ResponderCell")
    }
}

extension ResponderTableViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell: ResponderCell = tableView.dequeueReusableCellWithIdentifier("ResponderCell", forIndexPath: indexPath) as? ResponderCell else { return ResponderCell()}
        cell.btnClickBlock  = { text  in
            let  vc = ChatViewController()
            vc.title = text
            self.presentViewController(UINavigationController(rootViewController: vc), animated: true, completion: nil)
            
        }
        return cell
        
    }

}

typealias functionBlock = (text:String) -> ()
private class ResponderCell: UITableViewCell {
    var btnClickBlock: functionBlock?
    
    @objc func btnClick() {
        if let block = btnClickBlock {
            block(text: "我")
        }
       THURLNavigation.currentViewController()!.presentViewController(ChatViewController(), animated: true, completion: nil)
    }
    
    private lazy var botton: UIButton = {
        let btn = UIButton(type: UIButtonType.ContactAdd)
        btn.addTarget(self, action:#selector(ResponderCell.btnClick), forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()

  
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(botton)
        botton.snp_makeConstraints { (make) in
            make.center.equalTo(contentView.snp_center)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView {
    
    func getCurrentViewController(className:AnyClass) -> UIViewController? {
        var next = self.nextResponder()
        repeat {
            if ((next?.isKindOfClass(className)) != nil) {
                return next as? UIViewController
            }
            next = next?.nextResponder()
        } while (next != nil)
        
        return nil
    }
    
    func viewController(aClass: AnyClass) -> UIViewController?{
        for(var next=self.superview;(next != nil);next=next?.superview){
            let nextResponder = next?.nextResponder()
            if((nextResponder?.isKindOfClass(aClass)) != nil){
                return nextResponder as? UIViewController
            }
        }
        return nil
    }
    
}


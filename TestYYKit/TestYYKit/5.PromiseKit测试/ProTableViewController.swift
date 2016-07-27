//
//  ProTableViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/7/27.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import PromiseKit

class ProTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       setupPro()
    }
    
    private func setupPro()
    {
        
        // Promise 的每一层闭包中，我们可以再返回一个 Promise 对象，然后本来是层级嵌套的逻辑， 就变成了线性的逻辑了。
        NSURLSession.sharedSession().promise(NSURLRequest(URL: NSURL(string: "http://aaa.cc")!))
            .then { data in
            
            return NSURLSession.sharedSession().promise(NSURLRequest(URL: NSURL(string: "http://bbb.cc")!))
            
            }
            .then { data in
                
                return NSURLSession.sharedSession().promise(NSURLRequest(URL: NSURL(string: "http://ddd.cc")!))
                
            }
            .then { data in
                
                print("finished")
                
        }
        
        let req1 = NSURLSession.sharedSession().promise(NSURLRequest(URL: NSURL(string: "http://bbb.cc")!))
        let req2 = NSURLSession.sharedSession().promise(NSURLRequest(URL: NSURL(string: "http://ddd.cc")!))
        
        // 有些时候，我们可能会依赖于某些异步任务，需要等他们执行完成后，再进行一些操作。 PromiseKit 为我们提供了这样方便的接口， req1 和 req2 两个请求执行完毕后，在执行后面的闭包，如果期间发生错误， error 就会被调用。
        when(req1,req2).then { (resp1, resp2) -> Void in
            
        }.error { (err) in
            print(err)
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 0
    }

}

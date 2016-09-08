//
//  AlertViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/9/8.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import ReactiveCocoa

class AlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let btn = UIButton(type: .ContactAdd)
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(btn)
        btn.center = view.center
        btn.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext { (_) in
            let alter = UIAlertController(title: "test", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "push", style: UIAlertActionStyle.Default) { (_) in
                self.navigationController?.pushViewController(ViewController(), animated: true)
            }
            alter.addAction(action)
           self.presentViewController(alter, animated: true, completion: nil)
        }
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

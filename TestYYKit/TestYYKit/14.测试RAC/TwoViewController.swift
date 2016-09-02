//
//  TwoViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/8/30.
//  Copyright © 2016年 lieon. All rights reserved.
//
// swiftlint:disable trailing_whitespace

import UIKit
import ReactiveCocoa

class TwoViewController: UIViewController {

    var subject: RACSubject? = nil
    
    @IBAction func btbClick(sender: AnyObject) {
        if let sub = subject {
            sub.sendNext(nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

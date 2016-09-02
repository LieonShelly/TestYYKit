//
//  MenuViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/8/29.
//  Copyright © 2016年 lieon. All rights reserved.
//
// swiftlint:disable colon
// swiftlint:disable trailing_whitespace

import UIKit
import ElasticTransition

class MenuViewController: UIViewController, ElasticMenuTransitionDelegate {

    var contentLength:CGFloat = 320
    var dismissByBackgroundTouch = true
    var dismissByBackgroundDrag = true
    var dismissByForegroundDrag = true
    
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

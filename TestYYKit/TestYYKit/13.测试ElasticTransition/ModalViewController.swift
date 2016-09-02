//
//  ModalViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/8/29.
//  Copyright © 2016年 lieon. All rights reserved.
//
// swiftlint:disable trailing_whitespace

import UIKit
import ElasticTransition

class ModalViewController: UIViewController, ElasticMenuTransitionDelegate {
    var contentLength: CGFloat = 200
    var dismissByForegroundDrag: Bool = true
    var dismissByBackgroundDrag: Bool  = true
    var dismissByBackgroundTouch: Bool = true
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

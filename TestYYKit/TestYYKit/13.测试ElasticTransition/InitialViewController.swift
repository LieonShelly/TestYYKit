//
//  InitialViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/8/29.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import ElasticTransition


class InitialViewController: UIViewController {

    var transition = ElasticTransition()
    let lgr = UIScreenEdgePanGestureRecognizer()
    let rgr = UIScreenEdgePanGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       transition.sticky = true
        transition.showShadow = true
        transition.panThreshold = 0.4
        transition.transformType = .Subtle
        lgr.addTarget(self, action: #selector(self.handlePan(_:)))
        rgr.addTarget(self, action: #selector(self.handleRightPan(_:)))
        lgr.edges = .Left
        rgr.edges = .Right
        view.addGestureRecognizer(lgr)
        view.addGestureRecognizer(rgr)
        
    }

 
    func handlePan(pan:  UIScreenEdgePanGestureRecognizer) {
        if pan.state == .Began {
            transition.edge = .Left
            transition.startInteractiveTransition(self, segueIdentifier: "menu", gestureRecognizer: pan)
        } else {
            transition.updateInteractiveTransition(gestureRecognizer: pan)
        }
    }
    
    func handleRightPan(pan: UIScreenEdgePanGestureRecognizer) {
        if pan.state == .Began {
            transition.edge = .Right
            transition.startInteractiveTransition(self, segueIdentifier: "about", gestureRecognizer: pan)
        } else {
            transition.updateInteractiveTransition(gestureRecognizer: pan)
        }
    }
    
    @IBAction func aboutBtnClick(sender: AnyObject) {
        transition.edge = .Right
        transition.startingPoint = sender.center
        performSegueWithIdentifier("about", sender: self)
    }
 
    @IBAction func optionBtnClick(sender: AnyObject) {
        transition.edge = .Bottom
        transition.startingPoint = sender.center
        performSegueWithIdentifier("option", sender: self)
    }
 
 
    @IBAction func codeBtnCick(sender: AnyObject) {
        transition.edge = .Left
        transition.startingPoint = sender.center
        performSegueWithIdentifier("menu", sender: self)
    }

    @IBAction func modalBtnClick(sender: AnyObject) {
        guard  let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ModalViewController") as? ModalViewController else {
            return
        }
        transition.startingPoint = sender.center
        transition.edge = .Bottom
        vc.transitioningDelegate = transition
        vc.modalPresentationStyle = .Custom
        presentViewController(vc, animated: true, completion: nil)
        
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController
        vc.transitioningDelegate = transition
        vc.modalPresentationStyle = .Custom
        
    }
}

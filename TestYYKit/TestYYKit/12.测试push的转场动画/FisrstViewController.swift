//
//  FisrstViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/8/26.
//  Copyright © 2016年 lieon. All rights reserved.
//
// swiftlint:disable trailing_whitespace

import UIKit
import SnapKit

class FisrstViewController: UIViewController {

    let animator = RevealAnimator()
    let logo = RWLogoLayer.logoLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
     }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        logo.position = CGPoint(x: view.layer.bounds.size.width/2,
                                y: view.layer.bounds.size.height/2 + 30)
        logo.fillColor = UIColor.whiteColor().CGColor
        view.layer.addSublayer(logo)
    }
    
    func push() {
        navigationController?.pushViewController(SecondViewController(), animated: true)
    }
    
    private func setup() {
        navigationController?.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.push))
        view.addGestureRecognizer(tap)
        
    }
}

extension FisrstViewController: UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.operatiotn = operation
        return animator
    }
}

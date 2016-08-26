//
//  RevealAnimator.swift
//  TestYYKit
//
//  Created by lieon on 16/8/26.
//  Copyright © 2016年 lieon. All rights reserved.
//

///  转场动画的Demo在lieon的github上得DemoCode fork库上
import UIKit

class RevealAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let animaitonDuration: NSTimeInterval = 1.0
    var operatiotn: UINavigationControllerOperation = .Push
    weak var storedContext: UIViewControllerContextTransitioning?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
         return animaitonDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        storedContext = transitionContext
        if operatiotn == .Push {
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? FisrstViewController
            guard let fromVCC = fromVC else { return }
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
              guard let toVCC = toVC  else { return }
            transitionContext.containerView()?.addSubview(toVCC.view)
            let animation = CABasicAnimation(keyPath: "transform")
            animation.fromValue = NSValue(CATransform3D:CATransform3DIdentity)
            animation.toValue = NSValue(CATransform3D:CATransform3DConcat(CATransform3DMakeTranslation(0.0, -10.0, 0.0), CATransform3DMakeScale(150.0, 150.0, 1.0)))
            animation.duration = animaitonDuration
            animation.delegate = self
            animation.fillMode = kCAFillModeForwards
            animation.removedOnCompletion = false
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            // 同时添加到两个控制器上
            toVCC.view.layer.mask?.addAnimation(animation, forKey: nil)
            fromVCC.logo.addAnimation(animation, forKey: nil)
            // 给目标控制器设置一个渐变效果
            let fadeIn = CABasicAnimation(keyPath: "opacity")
            fadeIn.fromValue = 0.0
            fadeIn.toValue = 1.0
            fadeIn.duration = animaitonDuration
            toVCC.view.layer.addAnimation(fadeIn, forKey: nil)
            
        } else {
            let from = transitionContext.viewForKey(UITransitionContextFromViewKey)
            let to = transitionContext.viewForKey(UITransitionContextToViewKey)
            guard let fromView = from else { return }
            guard let toView = to else { return }
            transitionContext.containerView()?.insertSubview(toView, belowSubview: fromView)
            UIView.animateWithDuration(animaitonDuration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { 
                fromView.transform = CGAffineTransformMakeScale(0.001, 0.01)
                }, completion: { (_) in
               transitionContext.completeTransition(true)
            })
        }
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if let context = storedContext {
            
            context.completeTransition(!context.transitionWasCancelled())
            let fromVc = context.viewControllerForKey(UITransitionContextFromViewControllerKey) as! FisrstViewController
            fromVc.logo.removeAllAnimations()
        }
        
        storedContext = nil
    }
    
}

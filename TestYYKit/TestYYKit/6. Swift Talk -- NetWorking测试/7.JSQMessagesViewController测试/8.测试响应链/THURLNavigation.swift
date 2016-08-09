//
//  THURLNavigation.swift
//  WelcomeNewHome
//
//  Created by wanglj on 16/7/7.
//  Copyright © 2016年 TH. All rights reserved.
//

import UIKit

class THURLNavigation: NSObject {
    /**
     获取UIApplocation单例
     
     - returns: UIApplication
     */
    class func application() -> UIApplication {
        return UIApplication.sharedApplication()
    }
    
    private class func applicationDelegate() -> AppDelegate?{
        return application().delegate as? AppDelegate
    }
    /**
     获取当前正在显示的控制器
     
     - returns: 控制器
     */
    class func currentViewController() -> UIViewController? {
        let rootViewController = applicationDelegate()!.window!.rootViewController
        return currentViewControllerFrom(rootViewController!)
    }
    
    private class func currentViewControllerFrom(viewController:UIViewController) ->UIViewController? {
        if viewController.isKindOfClass(UINavigationController) {
            let navigationController = viewController as! UINavigationController
            return currentViewControllerFrom(navigationController.viewControllers.last!)
        }else if viewController .isKindOfClass(UITabBarController) {
            let tabBarController = viewController as! UITabBarController
            return currentViewControllerFrom(tabBarController.selectedViewController!)
        }else if viewController.presentedViewController != nil {
            return currentViewControllerFrom(viewController.presentedViewController!)
        }else {
            return viewController
        }
    }
    /**
     获取当前控制器的导航栏
     
     - returns: 导航栏
     */
    class func currentNavigationViewController() -> UINavigationController? {
        let currentViewController = self.currentViewController()
        return currentViewController?.navigationController
    }
    
    class func pushViewController(viewController:UIViewController, animated:Bool) {
        currentNavigationViewController()?.pushViewController(viewController, animated: animated)
    }
    
    class func presentViewController(viewController:UIViewController, animatied:Bool, completion:(() -> Void)) {
        let currentViewController = self.currentViewController()
        currentViewController?.presentViewController(viewController, animated: animatied, completion: completion)
    }
    
    class func dismissCurrentAnimated(animation:Bool) {
        let currentViewController = self.currentViewController()
        if currentViewController?.navigationController != nil {
            if currentViewController?.navigationController?.viewControllers.count == 1 {
                if currentViewController?.presentingViewController != nil {
                    currentViewController?.dismissViewControllerAnimated(animation, completion: nil)
                }
            }
            else {
                currentViewController?.navigationController?.popViewControllerAnimated(animation)
            }
        }
        else if currentViewController?.presentingViewController != nil {
            currentViewController?.dismissViewControllerAnimated(animation, completion: nil)
        }
        
    }

}

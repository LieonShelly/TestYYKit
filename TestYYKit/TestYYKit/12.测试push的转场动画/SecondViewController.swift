//
//  SecondViewController.swift
//  TestYYKit
//
//  Created by lieon on 16/8/26.
//  Copyright © 2016年 lieon. All rights reserved.
//
// swiftlint:disable trailing_newline
// swiftlint:disable force_cast
// swiftlint:disable colon
// swiftlint:disable control_statement
// swiftlint:disable valid_docs
// swiftlint:disable opening_brace
// swiftlint:disable trailing_newline
// swiftlint:disable trailing_whitespace

import UIKit

class SecondViewController: UIViewController {

    
    let maskLayer: CAShapeLayer = RWLogoLayer.logoLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "DETAILVC"
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(bgImage)
        view.addSubview(descLabel)
        descLabel.sizeToFit()
        descLabel.center = view.center
        
        
        maskLayer.position = CGPoint(x: view.layer.bounds.size.width/2, y: view.layer.bounds.size.height/2)
        view.layer.mask = maskLayer
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        view.layer.mask = nil
    }
    
    
    lazy var descLabel : UILabel = {
        let label = UILabel()
        label.text = "DetailViewController"
        label.textColor = UIColor.cyanColor()
        label.font = UIFont.systemFontOfSize(30)
        return label
    }()
    
    lazy var bgImage: UIImageView = {
        let bg = UIImageView()
        bg.image = UIImage(named: "anise")
        bg.frame = self.view.bounds
        return bg
    }()


}

class RWLogoLayer {
    
    class func logoLayer() -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.geometryFlipped = true
        
        let bezier = UIBezierPath()
        bezier.moveToPoint(CGPoint(x: 0.0, y: 0.0))
        bezier.addCurveToPoint(CGPoint(x: 0.0, y: 66.97), controlPoint1:CGPoint(x: 0.0, y: 0.0), controlPoint2:CGPoint(x: 0.0, y: 57.06))
        bezier.addCurveToPoint(CGPoint(x: 16.0, y: 39.0), controlPoint1: CGPoint(x: 27.68, y: 66.97), controlPoint2:CGPoint(x: 42.35, y: 52.75))
        bezier.addCurveToPoint(CGPoint(x: 26.0, y: 17.0), controlPoint1: CGPoint(x: 17.35, y: 35.41), controlPoint2:CGPoint(x: 26, y: 17))
        bezier.addLineToPoint(CGPoint(x: 38.0, y: 34.0))
        bezier.addLineToPoint(CGPoint(x: 49.0, y: 17.0))
        bezier.addLineToPoint(CGPoint(x: 67.0, y: 51.27))
        bezier.addLineToPoint(CGPoint(x: 67.0, y: 0.0))
        bezier.addLineToPoint(CGPoint(x: 0.0, y: 0.0))
        bezier.closePath()
        
        layer.path = bezier.CGPath
        layer.bounds = CGPathGetBoundingBox(layer.path)
        
        return layer
    }
}

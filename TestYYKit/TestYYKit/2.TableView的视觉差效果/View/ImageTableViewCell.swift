//
//  ImageTableViewCell.swift
//  TestYYKit
//
//  Created by lieon on 16/7/26.
//  Copyright © 2016年 lieon. All rights reserved.
//

// swiftlint:disable force_cast
// swiftlint:disable colon
// swiftlint:disable control_statement
// swiftlint:disable valid_docs
// swiftlint:disable opening_brace
// swiftlint:disable trailing_newline
// swiftlint:disable trailing_semicolon
// swiftlint:disable variable_name
// swiftlint:disable legacy_constant
// swiftlint:disable legacy_constructor
// swiftlint:disable comma
// swiftlint:disable trailing_whitespace

import UIKit

class ImageTableViewCell: UITableViewCell {

     func setCell(anchorPoint:CGPoint,angle:CGFloat)
    {
        //动画设置
        var transform = CATransform3DMakeRotation(angle, 0.0, 0.5, 0.3);
        
        transform.m34 = -1.0/500.0; // 设置透视效果
        layer.transform = transform;
        
        layer.anchorPoint = anchorPoint;
        
        UIView.animateWithDuration(0.6) { 
             self.layer.transform = CATransform3DIdentity;
        }
    }
}

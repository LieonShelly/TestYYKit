//
//  TableViewController.swift
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

class TableViewController: UITableViewController {

    
    var _lastScrollOffset:CGFloat = 0.0
    var _angle:CGFloat = 0.0
    var _cellAnchorPoint:CGPoint = CGPointZero
    let  kAngle = CGFloat((90.0 * M_PI) / 180.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "bak"))
        tableView.rowHeight = 204
        tableView.registerClass(ImageTableViewCell.self, forCellReuseIdentifier: "ImageTableViewCell")
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ImageTableViewCell", forIndexPath: indexPath) as! ImageTableViewCell
        let image = UIImage(named: String(indexPath.row + 1))
        
        cell.backgroundView = UIImageView(image: image)
        cell.setCell(_cellAnchorPoint, angle: kAngle)
    
        return cell
    }
 
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        var transform = CATransform3DIdentity
        transform =  CATransform3DRotate(transform, 0, 0, 0, 1);//渐变
        transform = CATransform3DTranslate(transform, -200, 0, 0)
        //由小到大的效果
        transform = CATransform3DScale(transform, 0, 0, 0)
        cell.layer.transform = transform
        cell.layer.opacity = 0.0;
        UIView.animateWithDuration(0.6) { 
            cell.layer.transform = CATransform3DIdentity;
            cell.layer.opacity = 1;
        }
    }

    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView != tableView {
            return
        }
        let y = scrollView.contentOffset.y;
        
        if (y > _lastScrollOffset) {//用户往上拖动
            // x=0 y=0 左
            // x=1 y=0 -angle 右
            _angle = -kAngle;
            _cellAnchorPoint = CGPointMake(1, 0);
            
        } else {//用户往下拖动
            // x=0 y=1 -angle 左
            // x=1 y=1 右
            _angle =  -kAngle;
            _cellAnchorPoint = CGPointMake(0, 1);
        }
        //存储最后的y值
        _lastScrollOffset = y;
    }
}

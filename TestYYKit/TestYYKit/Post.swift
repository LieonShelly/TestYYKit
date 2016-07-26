//
//  Post.swift
//  TestYYKit
//
//  Created by lieon on 16/7/26.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

class Post: NSObject {
    var postTitle: String = ""
    var postURL: String = ""
    
    init(dictionary: [String:AnyObject]) {
        self.postTitle = dictionary["postTitle"]! as! String
        self.postURL = dictionary["postURL"]! as! String
        super.init()
    }
}

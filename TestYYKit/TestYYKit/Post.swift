//
//  Post.swift
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

class Post: NSObject {
    var postTitle: String = ""
    var postURL: String = ""
    
    init(dictionary: [String:AnyObject]) {
        self.postTitle = dictionary["postTitle"]! as! String
        self.postURL = dictionary["postURL"]! as! String
        super.init()
    }
}

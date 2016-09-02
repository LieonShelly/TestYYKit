//
//  Model.swift
//  TestYYKit
//
//  Created by lieon on 16/8/31.
//  Copyright © 2016年 lieon. All rights reserved.
//
// swiftlint:disable trailing_whitespace

import Foundation
import ObjectMapper


public class Model: Mappable {
    
    init() {
        
    }
    
    // MARK: Mappable
    
    required public init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        
    }
    
}

// MARK: - Model Debug String
extension Model: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        var str = "\n"
        let properties = Mirror(reflecting: self).children
        for c in properties {
            if let name = c.label {
                str += name + ": \(c.value)\n"
            }
        }
        return str
    }
}

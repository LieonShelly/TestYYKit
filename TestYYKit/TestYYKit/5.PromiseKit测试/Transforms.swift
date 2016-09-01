//
//  Transforms.swift
//  TestYYKit
//
//  Created by lieon on 16/9/1.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import ObjectMapper

class Transforms: NSObject {

}

public class IntStringTransform: TransformType {
    public typealias object = Int
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> Int? {
        if let time = value as? String {
            return Int(time)
        }
        return nil
    }
    
    public func transformToJSON(value: Int?) -> String? {
        if let date = value {
            return String(date)
        }
        return nil
    }
}

public class ArrayOfURLTransform: TransformType {
    public typealias Object = [NSURL?]
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> [NSURL?]? {
        if let time = value as? [String] {
            /**
             *  将time数组中的元素遍历出来，转换为NSURL，在返回数组
             */
            return time.map { return NSURL(string: $0) }
        }
        return nil
    }
    
    public func transformToJSON(value: [NSURL?]?) -> String? {
        if let date = value {
            /// date数组存放的是NSURL类型的，通过flatmap将NSURL的String取出，组成一个新的数组
            let array = date.flatMap{ return $0?.absoluteString }
            return array.joinWithSeparator(",")
        }
        return nil
    }
}

public class FloatStringTransform: TransformType {
    public typealias Object = Float
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> Float? {
        if let time = value as? String {
            return Float(time)
        }
        return nil
    }
    
    public func transformToJSON(value: Float?) -> String? {
        if  let date = value {
            return String(date)
        }
        return nil
    }
}


public class BoolStringTransform: TransformType {
    public typealias Object = Bool
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> Bool? {
        if let time = value as? String {
            if time == "1" {
                return true
            } else {
                return false
            }
        }
        return nil
    }
    
    public func transformToJSON(value: Bool?) -> String? {
        if let date = value {
            if date == true {
                return "1"
            } else {
                return "0"
            }
        }
        return nil
    }
}

public class DoubleStringTransform: TransformType {
    public typealias Object = Double
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> Double? {
        if let time = value as? String {
            return Double(time)
        }
        return nil
    }
    
    public func transformToJSON(value: Double?) -> String? {
        if let date = value {
            return String(date)
        }
        return nil
    }
}

public class HtmlStringTransform: TransformType {
    public typealias Object = String
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> String? {
        if let time = value as? String {
            let string = time.stringByRemovingCharactersInSet(NSCharacterSet(charactersInString: "\""))
            return string
        }
        return nil
    }
    
    public func transformToJSON(value: String?) -> String? {
        if let date = value {
            return String(date)
        }
        return nil
    }
}

public class NSDataStringTransform: TransformType {
    public typealias Object = NSData
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> NSData? {
        if let time = value as? String {
            return NSData(base64EncodedString: time, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        }
        return nil
    }
    
    public func transformToJSON(value: NSData?) -> String? {
        if let date = value {
            return date.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        }
        return nil
    }
    
}

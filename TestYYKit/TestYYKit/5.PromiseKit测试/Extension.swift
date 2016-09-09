//
//  Extension.swift
//  TestYYKit
//
//  Created by lieon on 16/9/1.
//  Copyright © 2016年 lieon. All rights reserved.
//

// swiftlint:disable trailing_newline
// swiftlint:disable trailing_whitespace

import UIKit

extension String {
    func stringByRemovingCharactersInSet(characterSet: NSCharacterSet) -> String {
        return componentsSeparatedByCharactersInSet(characterSet).joinWithSeparator("")
    }
    
    func aesDecrypt(key: String, ivSalt: String) -> String {
        return (self as NSString).AES128DecryptWithKey(key, andIv: ivSalt)
    }
    
    func aesEncrypt(key: String, ivSalt: String) -> String {
        assert(key.characters.count == 16, "invalid key value")
        return (self as NSString).AES128EncryptWithKey(key, andIv: ivSalt)
    }
    
    func md5() -> String! {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CUnsignedInt(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.destroy()
        return String(format: hash as String)
    }

    static func randomText(length: Int) -> String {
        var text = ""
        for _ in 1...length {
            var decValue = 0  // ascii decimal value of a character
            var charType = 3  // default is lowercase
            charType =  Int(arc4random_uniform(3) + 1)
            switch charType {
            case 1:  // digit: random Int between 48 and 57
                decValue = Int(arc4random_uniform(10)) + 48
            case 2:  // uppercase letter
                decValue = Int(arc4random_uniform(26)) + 65
            case 3:  // lowercase letter
                decValue = Int(arc4random_uniform(26)) + 97
            default:  // space character
                decValue = 32
            }
            // get ASCII character from random decimal value
            let char = String(UnicodeScalar(decValue))
            text = text + char
        }
        return text
    }
}

extension UIColor {
    
    class func colorFromHex(rgbValue: UInt32, alpha: Double = 1.0) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/255.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/255.0
        let blue = CGFloat(rgbValue & 0xFF)/255.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    class func randomColor() -> UIColor {
        let r = arc4random_uniform(256)
        let g = arc4random_uniform(256)
        let b = arc4random_uniform(256)
        return  UIColor(red: CGFloat(r)/256.0, green: CGFloat(g)/256.0, blue: CGFloat(b)/256.0, alpha: 1.0)
    }
    
}

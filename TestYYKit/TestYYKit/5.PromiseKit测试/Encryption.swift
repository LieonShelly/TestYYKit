//
//  Encryption.swift
//  TestYYKit
//
//  Created by lieon on 16/9/1.
//  Copyright © 2016年 lieon. All rights reserved.
//
// swiftlint:disable trailing_whitespace
// swiftlint:disable trailing_newline

import Foundation
import ObjectMapper
import SwiftyRSA

class PayloadObject: Model {
    var header: Header?
    var post: [String: AnyObject] = [:]
    var get: [String: AnyObject] = [:]
    
    override func mapping(map: Map) {
        header <- map["header"]
        post <- map["post"]
        get <- map["get"]
    }
}

class KeysObject: Mappable {
    var hash: String
    var key: String
    var ivSalt: String
    
    init() {
        key = String.randomText(16)
        ivSalt = String.randomText(16)
        hash = ""
    }
    required init?(_ map: Map) {
          fatalError("init has not been implemented")
    }
    
    func mapping(map: Map) {
        hash <- map["hash"]
        key <- map["key"]
        ivSalt <- map["iv"]
    }
}

class PostData: Mappable {
    var keysObject: KeysObject
    var payloadObject: PayloadObject
    var keys: String
    var payload: String
    
    init() {
        keys = ""
        payload = ""
        keysObject = KeysObject()
        payloadObject = PayloadObject()
    }
    
    convenience init(param: Mappable?, header: Header?) {
        self.init()
        if let p = param {
            payloadObject.post = p.toJSON()
        }
        if let heade = header {
            payloadObject.header = heade
        }
        guard let payloadString = payloadObject.toJSONString() else { return }
        keysObject.hash = payloadString.md5()
        let publicKey = "随便写的"
        guard let keysString = keysObject.toJSONString() else { return }
        
        do {
            keys = try SwiftyRSA.encryptString(keysString, publicKeyPEM: publicKey)
        } catch _ {
            
        }
        
        payload = payloadString.aesEncrypt(keysObject.key, ivSalt: keysObject.ivSalt)
    }
    
    func decrypt(encryptString: String) -> String {
        let result = encryptString.aesDecrypt(keysObject.key, ivSalt: keysObject.ivSalt).stringByRemovingCharactersInSet(NSCharacterSet.controlCharacterSet())
        return result
    }
    
    required internal init?(_ map: Map) {
        fatalError("init has not been implemented")
    }
    
    func mapping(map: Map) {
        keys <- map["keys"]
        payload <- map["payload"]
    }
    
    
}
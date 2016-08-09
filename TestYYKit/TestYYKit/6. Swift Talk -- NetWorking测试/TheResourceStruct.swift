//
//  TheResourceStruct.swift
//  TestYYKit
//
//  Created by lieon on 16/8/8.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit


protocol EndPointProtocol {
    var endpoint: String { get }
    var baseURL: String { get }
    var path: String { get }
    
    func URL() -> String
}

extension EndPointProtocol {
    func URL() -> String {
        return self.baseURL + self.path + self.endpoint
    }
}

protocol UserProtocol: EndPointProtocol {}

public enum HomeBasicPath: UserProtocol {
    case HomeBanner
    case HomeData
    case BasicData
    case Captcha
    case SmsVerifyCode
    case RegionCode
    
    
    var path: String {
        return "index/"
    }
    
    var endpoint: String {
        switch self {
        case HomeBanner:
            return "banner"
        case HomeData:
            return "index"
        case BasicData:
            return "base_data"
        case Captcha:
            return "img_captcha"
        case SmsVerifyCode:
            return "sms_verify_code"
        case RegionCode:
            return "regions"
        }
    }
    
    var baseURL: String {
        return "base"
    }
}

struct Resource<A> {
    let url: NSURL?
    let parse: NSData -> A?
    
    init(url:NSURL?, parse: NSData -> A?) {
        self.url = url
        self.parse = parse
    }
}

struct Episode {
    let id: String
    let title: String
    // ...
}

extension Episode {
  
    
    init?(dictionary: JSONDictionary) {
        guard let id = dictionary["id"] as? String,
            title = dictionary["title"] as? String else { return nil }
        self.id = id
        self.title = title
    }
}


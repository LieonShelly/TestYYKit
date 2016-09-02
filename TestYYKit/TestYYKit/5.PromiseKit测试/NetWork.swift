//
//  NetWork.swift
//  TestYYKit
//
//  Created by lieon on 16/8/31.
//  Copyright © 2016年 lieon. All rights reserved.
//

// swiftlint:disable trailing_newline
// swiftlint:disable trailing_whitespace

import UIKit
import ObjectMapper

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

protocol UserProtocol: EndPointProtocol { }
protocol ContentProtocol: EndPointProtocol {}
protocol BusinessProtocol: EndPointProtocol {}
protocol MarketProtocol: EndPointProtocol {}
protocol FileUploadProtocol: EndPointProtocol {}

class Header: Model {
    var appVersion: String = (NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String) ?? "1.0"
    var deviceUUID: String = "sdfsdfsdfdsfdsfw"
    var deviceModel: String = "1"
    var deviceVersion: String = UIDevice.currentDevice().systemVersion
//    var devicePushToken: String? = AppConfig.sharedManager.pushToken
    var appSessionToken: String? = ""
    var contentType: String = "application/json"
    var appRole: String = "member"
    
    override func mapping(map: Map) {
        appVersion <- map["APP_VERSION"]
        deviceUUID <- map["DEVICE_UUID"]
        deviceModel <- map["DEVICE_MODEL"]
        deviceVersion <- map["DEVICE_VERSION"]
//        devicePushToken <- map["DEVICE_TOKEN"]
        appSessionToken <- map["APP_TOKEN"]
        contentType <- map["Content-Type"]
        appRole <- map["APP_ROLE"]
    }
}
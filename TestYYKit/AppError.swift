//
//  AppError.swift
//  TestYYKit
//
//  Created by lieon on 16/9/1.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit

private let domain = "cn.chcts.bank"

protocol ErrorCode {
    func errorCode() -> Int
}

public enum RequestErrorCode: String, ErrorCode {
    case Success = "0"
    case WrongIDPass = "103001"
    case OldPassError = "103014"
    case UserExist = "103031"
    case ImageCaptchaError = "201003"
    case PayPassError = "103037"
    case InfoError = "103035"
    case PayPassLock = "103052"
    case OldPayPassError = "103056"
    case InputTwoDiffPass = "1302"
    case NeedEnoughPoint = "1304"
    case NeedRiskAssess = "203001"
    case AnswerWrong = "404004"
    //抽奖次数用完
    case CountsRunOut = "406001"
    
    case InvalidSSHKey = "-1001"
    case NeedRelogin = "-1002"
    case UnKnown = "-100"
    
    func errorCode() -> Int {
        //        print(Int(rawValue) ?? -100)
        return Int(rawValue) ?? -100
    }
}

public struct AppError: ErrorType {
    var errorCode: ErrorCode
    private var message: String?
    
    init(code: ErrorCode, msg: String? = nil) {
        errorCode = code
        message = msg
    }
    
    func toError() -> NSError {
        if errorCode is RequestErrorCode {
            guard let message = message else {
                return NSError(domain:domain , code: errorCode.errorCode(), userInfo: nil)
            }
            let info = [NSLocalizedDescriptionKey:message] as [String: AnyObject]
            return NSError(domain: domain, code: errorCode.errorCode(), userInfo: info)
        }
        return NSError(domain: domain, code: -10000, userInfo: nil)
    }
}

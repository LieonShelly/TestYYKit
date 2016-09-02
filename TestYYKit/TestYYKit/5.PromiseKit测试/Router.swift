//
//  Router.swift
//  TestYYKit
//
//  Created by lieon on 16/8/31.
//  Copyright © 2016年 lieon. All rights reserved.
//
// swiftlint:disable trailing_whitespace
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


import Foundation
import Alamofire
import ObjectMapper
import UIKit

enum Router: URLRequestConvertible {
  
    case Endpoint(endPoint: EndPointProtocol, param: Mappable?)
    case EndPointWithoutToken(endPoint: EndPointProtocol, param: Mappable?)
    case upload(endPoint: EndPointProtocol)
    var param: Mappable? {
        switch self {
        case .Endpoint(_,let param):
            return param
        case .EndPointWithoutToken(_, param: let param):
            return param
        default:
            return nil
        }
    }
    var URLRequest: NSMutableURLRequest {
        guard var head = Header().toJSON() as? [String:String] else {
            return NSMutableURLRequest()
        }
        switch self {
        case .Endpoint(endPoint: let path, param: let param):
            let result: (path: String, parameters: [String: AnyObject]?) = (path.URL(),(param?.toJSON() ?? nil))
            let URL = NSURL(string: result.path)!
            let URLRequest = NSMutableURLRequest(URL: URL)
            URLRequest.HTTPMethod = method.rawValue
            head.forEach({ (key,value) in
                URLRequest.setValue(value, forHTTPHeaderField: key)
            })
            let encoding = ParameterEncoding.JSON
            return encoding.encode(URLRequest, parameters: result.parameters).0
        case .EndPointWithoutToken(endPoint: let path, param: let param):
            let result: (path: String, parameters: [String: AnyObject]?) = (path.URL(),(param?.toJSON()) ?? nil)
            let URL = NSURL(string: result.path)!
            let URLRequest = NSMutableURLRequest(URL: URL)
            URLRequest.HTTPMethod = method.rawValue
            head.removeValueForKey("APP_TOKEN")
            head.forEach({ (key, value) in
                URLRequest.setValue(value, forHTTPHeaderField: key)
            })
            let encoding = ParameterEncoding.JSON
            return encoding.encode(URLRequest, parameters: result.parameters).0
        case .upload(endPoint: let path):
            let URL = NSURL(string: path.URL())!
            let URLRequest = NSMutableURLRequest(URL: URL)
            URLRequest.HTTPMethod = method.rawValue
            head.removeValueForKey("Content-Type")
            head.forEach({ (key, value) in
                URLRequest.setValue(value, forHTTPHeaderField: key)
            })
            let encoding = ParameterEncoding.JSON
            return encoding.encode(URLRequest, parameters: nil).0
        }
    }
    var method: Alamofire.Method {
        switch self {
        default:
            return .POST
        }
    }
    var header: Header? {
        switch self {
        case .Endpoint(endPoint: _, param: _):
            return Header()
        case .EndPointWithoutToken(endPoint: _, param: _):
            let header = Header()
            header.appSessionToken = nil
            return header
        default:
            return nil
        }
    }
    
}

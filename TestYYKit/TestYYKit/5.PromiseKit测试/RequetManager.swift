//
//  RequetManager.swift
//  TestYYKit
//
//  Created by lieon on 16/8/31.
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
// swiftlint:disable statememt_position
// swiftlint:disable trailing_whitespace

import UIKit
import Alamofire
import PromiseKit
import ObjectMapper
/**
  请求数据
 
 - parameter router: 请求的路径
 
 - returns: 请求的整个json模型，
 */
func handRequest<T: Mappable>(router: Router) -> Promise<T> {
    return Promise(resolvers: { (fulfill, reject) in
       let param = router.param
    
       let postData = PostData(param: param, header: router.header)
        let _ = request(.POST, router.URLRequest.URLString, parameters: postData.toJSON(), encoding: .JSON, headers: nil).validate().responseJSON(completionHandler: { (reponse: Response<AnyObject, NSError>) in
        switch reponse.result {
        case .Success(let value ):
            if let dic = value as? [String: String], payload = dic["payload"] where !payload.isEmpty {
                let jsonString = postData.decrypt(payload)
                let object = Mapper<BaseReponseObjec<T>>().map(jsonString)
                if let base = object {
                    if base.isValid {
                        if let object = Mapper<T>().map(jsonString) {
                            fulfill(object)
                        }
                    } else {
                        let error =  AppError(code: base.code, msg: base.msg)
                        reject(error)
                    }
                } else {
                    let error = AppError(code: RequestErrorCode.UnKnown, msg: nil)
                    reject(error)
                }
            }
        case .Failure(let error):
            reject(error)
        }
            
       })
        
    })
}
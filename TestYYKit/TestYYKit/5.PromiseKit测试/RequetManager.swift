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
import Kingfisher
import AlamofireImage

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

func handDownloadPhoto(router: NSURL?) -> Promise<Image?> {
    return Promise(resolvers: { (fulfill, reject) in
       if let URL = router where !URL.absoluteString.isEmpty {
        _ = request(.GET, URL).validate().responseImage(completionHandler: { (response:Response<Image, NSError>) in
            switch response.result {
            case .Success(let value):
                fulfill(value)
            case .Failure(_):
                fulfill(nil)
            }
            })
       } else {
        fulfill(nil)
        }
    })
}

func handleUpload(router: URLRequestConvertible, param: FileUploadParameter, fileData: [NSData]) -> Promise<FileUploadResponse> {
    return Promise { fulfill, reject in
        let _ = upload(router, multipartFormData: { multipartFormData in
            fileData.forEach { (data) in
                multipartFormData.appendBodyPart(data: data, name: "image[]", fileName: "image.jpg", mimeType: "image/jpeg")
            }
            
            guard let dic = param.toJSON() as? [String: String] else {
                return
            }
            for (key, value) in dic {
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
            }
            }, encodingCompletion: { result in
                switch result {
                case .Success(let upload, _, _):
                    upload
                        .validate()
                        .responseJSON(completionHandler: { (response: Response<AnyObject, NSError>) in
                            switch response.result {
                            case .Success(let value):
                                if let base = Mapper<FileUploadResponse>().map(value) {
                                    if base.isValid {
                                        fulfill(base)
                                    } else {
                                        let error = AppError(code: base.code, msg: base.msg)
                                        if base.needRelogin {
//                                            if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate, containerVC = delegate.containerVC {
//                                                containerVC.needLogin()
//                                            }
                                        }
                                        reject(error)
                                    }
                                }
                            case .Failure(let error):
                                reject(error)
                            }
                        })
                case .Failure(let error):
                    reject(error)
                }
        })
    }
}


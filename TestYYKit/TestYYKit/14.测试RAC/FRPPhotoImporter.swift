//
//  FRPPhotoImporter.swift
//  TestYYKit
//
//  Created by lieon on 16/9/9.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import _500px_iOS_api
import ReactiveCocoa
import ObjectMapper

class FRPPhotoImporter: NSObject {

    func popularURLRequest() -> NSURLRequest {
        let apiHelper = PXAPIHelper(host: nil, consumerKey: "DC2To2BS0ic1ChKDK15d44M42YHf9gbUJgdFoF0m", consumerSecret: "i8WL4chWoZ4kw9fh3jzHK7XzTer1y5tUNvsTFNnB")
        return apiHelper.urlRequestForPhotoFeature(PXAPIHelperPhotoFeature.Popular, resultsPerPage: 100, page: 0, photoSizes: PXPhotoModelSize.Thumbnail, sortOrder: PXAPIHelperSortOrder.Rating, except:PXPhotoModelCategory.PXPhotoModelCategoryNude )
    }
    
    func requestPhotoData() -> RACSignal {
        let request = popularURLRequest()
        return NSURLConnection.rac_sendAsynchronousRequest(request)
        
    }
    
//    func importPhotos() -> RACSignal {
//        return requestPhotoData().deliverOn(RACScheduler.mainThreadScheduler()).map({ (data) -> AnyObject in
//            do {
//                let results = try NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions.MutableContainers)
//                let jsonDic = results as? Dictionary<String, AnyObject>
//                if let dic = jsonDic {
//                    return dic["photos"]!.rac_sequence.map({ (photoDictionary) -> AnyObject in
//                        let model = Mapper<FRPPhotoModel>().map(dic)
//                        return model
//                    })
//                }
//            } catch {
//                print(error)
//            }
//        }).
//        
//    }
    
   
}

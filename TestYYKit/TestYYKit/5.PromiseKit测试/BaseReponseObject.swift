//
//  BaseReponseObject.swift
//  TestYYKit
//
//  Created by lieon on 16/9/1.
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
// swiftlint:disable trailing_whitespace

import UIKit
import ObjectMapper

class BaseReponseObjec<T: Mappable>: Mappable {
    
    var status: Bool = true
    var code: RequestErrorCode = .UnKnown
    var msg: String?
    var needRelogin: Bool = false
    var data: T?
    
    var isValid: Bool {
        // FIXME: !!! status type
        return status && code == .Success
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- (map["status"], BoolStringTransform())
        code <- map["code"]
        msg <- map["msg"]
        needRelogin <- (map["need_relogin"], BoolStringTransform())
        data <- map["data"]
    }
}

/// BaseReponseObjec为json的外部，LifeHome为json关键字data所对应的数据模型，相当于一个<  > 对应一个 {  }
/**
 {
 "status": "1",
 "code": 0,
 "msg": "",
 "data": {
             "doc_id": "1",
             "title": "上海清风服饰有限公司",
             "detail_link": "detail_link"
             "data":{
                     }
         },
 "need_relogin": "0"
 }
 */
class LifeHomeData: BaseReponseObjec<LifeHome<String>> {}

/// 首页数据
class LifeHome<T>: Model {
    var productList: [Product]?
    var goodsList: [Goods]?
//    var goodsCatsList: [GoodsCats]?
    var data:T?
    
    override func mapping(map: Map) {
        productList <- map["finance_product_list"]
        goodsList <- map["goods_list"]
//        goodsCatsList <- map["goods_cat_list"]
    }
}


//投资理财产品
class Product: Model {
    var productID: String = ""
    var title: String?
    /// 收益类型
//    var type: ProductProfitType?
    var number: Int?
    // 计息开始时间
    var interestStart: NSDate?
    // 计息结束时间
    var interestEnd: NSDate?
    /// 开始时间
    var saleStart: NSDate?
    /// 结束时间
    var saleEnd: NSDate?
    /// 年化收益
    var profit: Float = 0
    var saleNum: Int?
    /// 计息方式
//    var interestType: InterestType?
    /// 收益计算方式
//    var incomeCalculation: IncomeCalculationType?
    /// 风险提示
    var risk: String?
    var remark: String?
    /// 购买金额
    var boughtAmount: Float = 0
    /// 是否人气
    var isHot: Bool = false
    /// 是否保本
    var isGuarantee: Bool = false
    /// 起投金额
    var minAmount: Float = 0
    /// 年化收益
    var aer: Float?
    var news: String?
//    var status: ProductsStatus?
    
    var shareURL: NSURL?
    var html: String?
    
    override func mapping(map: Map) {
        productID <- map["product_id"]
        title <- map["title"]
//        type <- map["type"]
        number <- (map["money"], IntStringTransform())
        interestStart <- (map["interest_start"], CustomDateFormatTransform(formatString: "yyyy-MM-dd"))
        interestEnd <- (map["interest_end"], CustomDateFormatTransform(formatString: "yyyy-MM-dd"))
        saleStart <- (map["sale_start"], CustomDateFormatTransform(formatString: "yyyy-MM-dd"))
        saleEnd <- (map["sale_end"], CustomDateFormatTransform(formatString: "yyyy-MM-dd"))
        profit <- (map["profit"], FloatStringTransform())
        saleNum <- (map["sale_num"], IntStringTransform())
//        interestType <- map["interest_type"]
//        incomeCalculation <- map["income_calculation"]
        risk <- map["risk"]
        remark <- map["remark"]
        
        boughtAmount <- (map["amount"], FloatStringTransform())
        isHot <- (map["is_hot"], BoolStringTransform())
        isGuarantee <- (map["is_guarantee"], BoolStringTransform())
        minAmount <- (map["min_amount"], FloatStringTransform())
        aer <- (map["aer"], FloatStringTransform())
        news <- map["news"]
//        status <- map["status"]
        shareURL <- (map["share_url"], URLTransform())
        html <- map["html"]
    }
}

class ProductList: Model {
    var totalPage: Int?
    var totalItems: Int?
    var currentPage: Int?
    var perpage: Int?
    var items: [Product]?
    
    override func mapping(map: Map) {
        totalPage <- (map["total_page"], IntStringTransform())
        totalItems <- (map["total_items"], IntStringTransform())
        currentPage <- (map["current_page"], IntStringTransform())
        perpage <- (map["perpage"], IntStringTransform())
        items <- map["items"]
    }
}

// 商品
class Goods: Model {
    var goodsID: String = ""
    var title: String?
    var imageURL: NSURL?
    var price: Float = 0
    /// 商品原价
    var marketPrice: Float = 0
//    var status: GoodsStatus?
//    var type: GoodsType?
    var sellNum: Int = 0
    /// 收藏时间
    var expireTime: NSDate?
    /// 是否已收藏
    var isMarked: Bool?
    /// 购物车数量
    var cartGoodsCount: Int?
    var eventCount: Int?
    var canChecked: Bool = false
    var deliveryCost: Float?
    var num: Int = 0
    /// 库存数量
    var stockNum: Int?
    var point: Int?
//    var events: [OnlineEvent]?
    
    var isChecked: Bool = false
    var thumb: NSURL?
    var merchantID: String?
    var summary: String?
//    var couponList: [Coupon]?
    var html: String?
    var shareURL: NSURL?
    /// 评分
    var source: Float = 0
    
    override func mapping(map: Map) {
        //super.mapping(map)
        goodsID <- map["goods_id"]
        title <- map["title"]
        imageURL <- (map["cover"], URLTransform())
        price <- (map["price"], FloatStringTransform())
        marketPrice <- (map["market_price"], FloatStringTransform())
//        status <- map["status"]
//        type <- map["type"]
        sellNum <- (map["sell_num"], IntStringTransform())
        expireTime <- (map["expire_time"], CustomDateFormatTransform(formatString: "yyyy-MM-dd"))
        isMarked <- (map["is_marked"], BoolStringTransform())
        cartGoodsCount <- (map["cart_goods_count"], IntStringTransform())
        eventCount <- (map["event_count"], IntStringTransform())
        canChecked <- (map["can_checked"], BoolStringTransform())
        deliveryCost <- (map["delivery_cost"], FloatStringTransform())
        num <- (map["num"], IntStringTransform())
        stockNum <- (map["stock_num"], IntStringTransform())
        point <- (map["point_percent"], IntStringTransform())
//        events <- map["events"]
        isChecked <- (map["is_checked"], BoolStringTransform())
        thumb <- (map["thumb"], URLTransform())
        merchantID <- map["merchant_id"]
        summary <- map["summary"]
//        couponList <- map["coupon_list"]
        html <- (map["html"])
        shareURL <- (map["share_url"], URLTransform())
        source <- (map["score"], FloatStringTransform())
    }
}

/// 上传文件
class FileUploadResponse: BaseReponseObjec<FileListObject> {}

class FileListObject: Model {
    var successList: [FileObject]? = []
    
    override func mapping(map: Map) {
        successList <- map["success"]
    }
}

class FileObject: Model {
    var path: String?
    var url: NSURL?
    var name: String?
    var size: UInt64?
    var type: String?
    
    override func mapping(map: Map) {
        path <- map["file_name"]
        url <- (map["url"], URLTransform())
        name <- map["name"]
        size <- map["size"]
        type <- map["image/jpeg"]
    }
}


//
//  MyOrders.swift
//  PerseusShelfUnion
//
//  Created by 123 on 16/12/27.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import Foundation

class Model_MyOrders: NSObject {
    // 请求
    //    class Requesting: NSObject {
    //        var RobOrderID: Int?
    //        init(RobOrderID: Int?) {
    //            self.RobOrderID = RobOrderID
    //        }
    //    }
    
    // 响应
    class Response: NSObject {
        var InsCycle: String?
        var InsPlace: String?
        var MyOrderID: String?
        var Title: String?
        var StartTime: String?
        var StateCode: CodeType?
        var Tonnage: String?
        init(InsCycle: String?,
             InsPlace: String?,
             MyOrderID: String?,
             Title: String?,
             StartTime: String?,
             StateCode: CodeType?,
             Tonnage: String?) {
            self.InsCycle = InsCycle
            self.InsPlace = InsPlace
            self.MyOrderID = MyOrderID
            self.Title = Title
            self.StartTime = StartTime
            self.StateCode = StateCode
            self.Tonnage = Tonnage
        }
    }
    
    enum CodeType: Int {
        case 未审核 = 1
        case 审核通过 = 2
        case 审核失败 = 4
        case 待安装 = 8
        case 在安装 = 16
        case 已完成 = 32
        case 已完结 = 64
    }
}

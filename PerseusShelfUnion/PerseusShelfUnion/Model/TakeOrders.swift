//
//  TakeOrders.swift
//  PerseusShelfUnion
//
//  Created by 123 on 16/12/26.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import Foundation
class Model_TakeOrders: NSObject {
    /// 请求
//    class Requesting: NSObject {
//        
//        init() {
//        }
//    }
    
    /// 响应
    class Response: NSObject {
        var InstallCycle: String?
        var InstallPlace: String?
        var RobOrderID: Int?
        var StartTime: String?
        var Code: CodeType?
        var Title: String?
        var Tonnage: String?
        init(InstallCycle: String?,
             InstallPlace: String?,
             RobOrderID: Int?,
             StartTime: String?,
             Code: CodeType?,
             Title: String?,
             Tonnage: String?) {
            self.InstallCycle = InstallCycle
            self.InstallPlace = InstallPlace
            self.RobOrderID = RobOrderID
            self.StartTime = StartTime
            self.Code = Code
            self.Title = Title
            self.Tonnage = Tonnage
        }
    }
    
    enum CodeType: Int {
        case 未抢1 = 1
        case 未抢2 = 2
        case 未抢3 = 3
        case 未抢4 = 4
        case 已抢 = 5
    }
}

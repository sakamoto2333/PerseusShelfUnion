//
//  MyPlanDetail.swift
//  PerseusShelfUnion
//
//  Created by 123 on 17/1/11.
//  Copyright © 2017年 XHVolunteeriOS. All rights reserved.
//

import Foundation
class Model_MyPlanDetail: NSObject {
    /// 请求
    class Requesting: NSObject {
        var OrderID: String?
        var Day: Int?
        init(OrderID: String?,
             Day: Int?) {
            self.OrderID = OrderID
            self.Day = Day
        }
    }
    
    /// 响应
    class Response: NSObject {
        var Code: Int?
        var ProcessID: String?
        var Procedure: String?
        var Tools: String?
        var LiablePerson: String?
        var Manual: String?
        var DayItemTime: String?
        init(Code: Int?,
             ProcessID: String?,
             Procedure: String?,
             Tools: String?,
             LiablePerson: String?,
             Manual: String?,
             DayItemTime: String?) {
            self.Code = Code
            self.ProcessID = ProcessID
            self.Procedure = Procedure
            self.Tools = Tools
            self.LiablePerson = LiablePerson
            self.Manual = Manual
            self.DayItemTime = DayItemTime
        }
    }
}

//
//  MyPlanAdd.swift
//  PerseusShelfUnion
//
//  Created by 123 on 17/1/10.
//  Copyright © 2017年 XHVolunteeriOS. All rights reserved.
//

import Foundation
class Model_MyPlanAdd: NSObject {
    ///请求
    class Requesting:NSObject{
        var Procedure: String?
        var Tools: String?
        var LiablePerson: String?
        var Manual: String?
        var DayItem: Int?
        var OrderID: String?
        init(Procedure: String?,
            Tools: String?,
            LiablePerson: String?,
            Manual: String?,
            DayItem: Int?,
            OrderID: String?) {
            self.Procedure = Procedure
            self.Tools = Tools
            self.LiablePerson = LiablePerson
            self.Manual = Manual
            self.DayItem = DayItem
            self.OrderID = OrderID
        }
    }
    
    enum Code: Int {
        case 请输入工序 = 0
        case 请输入工具 = 1
        case 请输入负责人 = 2
        case 请输入人工 = 3
        case 添加成功 = 4
    }
}

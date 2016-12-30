//
//  TakeOrderDetails.swift
//  PerseusShelfUnion
//
//  Created by 123 on 16/12/26.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import Foundation
class Model_TakeOrderDetails: NSObject {
    // 请求
    class Requesting: NSObject {
        var RobOrderID: Int?
        init(RobOrderID: Int?) {
            self.RobOrderID = RobOrderID
        }
    }
    
    // 响应
    class Response: NSObject {
        var InsAtticLayer: String?
        var InsBeamHgh: String?
        var InsHeight: String?
        var InsName: String?
        var InsFork: String?
        var InsCycle: String?
        var InsPlace: String?
        var InsMoney: String?
        var Weight: String?
        var InsPhone: String?
        var InsRemarks: String?
        var StartTime: String?
        var Structure: String?
        var Tonnage: String?
        var InsType: String?
        init(InsAtticLayer: String?,
             InsBeamHgh: String?,
             InsHeight: String?,
             InsName: String?,
             InsFork: String?,
             InsCycle: String?,
             InsPlace: String?,
             InsMoney: String?,
             Weight: String?,
             InsPhone: String?,
             InsRemarks: String?,
             StartTime: String?,
             Structure: String?,
             Tonnage: String?,
             InsType: String?) {
            self.InsAtticLayer = InsAtticLayer
            self.InsBeamHgh = InsBeamHgh
            self.InsHeight = InsHeight
            self.InsName = InsName
            self.InsFork = InsFork
            self.InsCycle = InsCycle
            self.InsPlace = InsPlace
            self.InsMoney = InsMoney
            self.Weight = Weight
            self.InsPhone = InsPhone
            self.InsRemarks = InsRemarks
            self.StartTime = StartTime
            self.Structure = Structure
            self.Tonnage = Tonnage
            self.InsType = InsType
        }
    }
    
    enum CodeType: Int {
        case 抢单成功 = 4
        case 已抢 = 5
    }
    
    var PriceUnitType:[Int:String] = [0:"元／吨",
                                      1:"元／千克",
                                      2:"元／克",
                                      3:"元／斤",
                                      4:"元／加仑"
    ]
}

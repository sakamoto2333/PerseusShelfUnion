//
//  IOrdersReposity.swift
//  PerseusShelfUnion
//
//  Created by dmql on 16/12/23.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import Foundation

protocol IOrdersReposity{
    
    /// 抢单列表
    func TakeOrders()
    
    /// 抢单详细
    func TakeOrderDetails(Requesting : Model_TakeOrderDetails.Requesting)
    
    /// 我的订单
    func MyOrders()
}

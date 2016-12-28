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
    ///
    /// - Parameter Requesting: 单子ID
    func TakeOrderDetails(Requesting : Model_TakeOrderDetails.Requesting)
    
    /// 申请抢单
    ///
    /// - Parameter Requesting: 单子ID和用户ID
    func GetOrder(Requesting : Model_GetOrder.Requesting)
    
    /// 我的订单
    func MyOrders()
}

//
//  IUserReposity.swift
//  PerseusShelfUnion
//
//  Created by dmql on 16/12/20.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import Foundation

protocol IUserReposity {
    
    /// 登录
    ///
    /// - Parameter Requesting: LoginUser数据模型
    func LoginUser(Requesting: Model_LoginUser.Requesting)
    
    
    /// 注册
    ///
    /// - Parameter Requesting: RegistrationUser数据模型
    func RegistrationUser(Requesting: Model_RegistrationUser.Requesting)
    
    
    func MyInformation(Requesting: Model_MyInformation.Requesting)
    
    func MyData(Requesting: Model_MyData.Requesting)
}

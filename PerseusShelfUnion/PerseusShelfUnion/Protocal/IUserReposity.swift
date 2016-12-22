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
    /// - Parameters:
    ///   - UserName: 用户名
    ///   - UserPassword: 密码
    func LoginUser(Requesting: Model_LoginUser.Requesting)
}

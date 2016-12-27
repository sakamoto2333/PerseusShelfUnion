//
//  RegistrationUser.swift
//  PerseusShelfUnion
//
//  Created by dmql on 16/12/23.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import Foundation
class Model_RegistrationUser: NSObject {
    /// 请求
    class Requesting: NSObject {
        var UserName: String
        var Password: String
        var UnitName: String
        
        init(UserName: String,
            Password: String,
            UnitName: String) {
            self.UserName = UserName
            self.Password = Password
            self.UnitName = UnitName
        }
    }
    
    /// 响应
    class Response: NSObject {
        var Code:CodeType?
        var UserName: String?
        
        init(Code:CodeType?,
             UserName: String?) {
            self.Code = Code
            self.UserName = UserName
        }
    }
    
    enum CodeType:Int {
        case 请输入公司名 = 0
        case 请输入用户名 = 1
        case 请输入密码 = 2
        case 注册成功 = 3
        case 用户名已存在 = 4
    }
}

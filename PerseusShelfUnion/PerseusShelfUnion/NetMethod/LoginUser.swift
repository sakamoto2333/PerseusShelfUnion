//
//  LoginUser.swift
//  PerseusShelfUnion
//
//  Created by dmql on 16/12/22.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import Foundation
class Model_LoginUser: NSObject {
    
    /// 请求
    class Requesting: NSObject {
        var UserName:String
        var Password:String
        
        init(UserName:String,
             Password:String) {
            self.UserName = UserName
            self.Password = Password
        }
    }
    
    /// 响应
    class Response: NSObject {
        var Code:CodeType?
        var IsProved:Int?
        var UserID:String?
        var UserName:String?
        
        init(Code:CodeType?,
             IsProved:Int?,
             UserID:String?,
             UserName:String?) {
            self.Code = Code
            self.IsProved = IsProved
            self.UserID = UserID
            self.UserName = UserName
        }
    }
    
    enum CodeType:Int {
        case 请输入用户名 = 0
        case 请输入密码 = 1
        case 登录成功 = 2
        case 该用户尚未启动 = 3
        case 用户名密码不正确 = 4
        case 没有该用户 = 5
    }
}


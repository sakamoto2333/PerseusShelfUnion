//
//  MyInformation.swift
//  PerseusShelfUnion
//
//  Created by dawen wang on 16/12/28.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import Foundation
class Model_MyInformation:NSObject{
    
    ///请求
    class Requesting:NSObject{
        var UserName: String
        
        init(UserName: String) {
            self.UserName = UserName
        }
    }
    
    ///响应
    class Response:NSObject{
        var UserPic: String?
        var PhoneNum: String?
        var UserName: String?
        var UserMail: String?
        var Unit: String?
        var Job: String?
        var Code: String?
        init(UserPic: String?,
             PhoneNum: String?,
             UserName: String?,
             UserMail: String?,
             Unit: String?,
             Job: String?,
             Code: String?) {
            self.UserPic = UserPic
            self.PhoneNum = PhoneNum
            self.UserName = UserName
            self.UserMail = UserMail
            self.Unit = Unit
            self.Job = Job
            self.Code = Code
            
        }
    }
}


//
//  MyCredit.swift
//  PerseusShelfUnion
//
//  Created by dawen wang on 17/1/5.
//  Copyright © 2017年 XHVolunteeriOS. All rights reserved.
//

import Foundation
class Model_MyCredit: NSObject {
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
        var Unit: String?
        init(UserPic: String?,
             PhoneNum: String?,
             Unit: String?) {
            self.UserPic = UserPic
            self.PhoneNum = PhoneNum
            self.Unit = Unit
        }
    }
}

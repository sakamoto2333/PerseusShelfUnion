//
//  ErrorMessages.swift
//  PerseusShelfUnion
//
//  Created by dmql on 16/12/14.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import Foundation

class ErrorMessages: NSObject {
    var ErrorCode = [Int:String]()
    override init() {
        ErrorCode[0x1001] = "请输入用户名和密码"
    }
    
    
    func ApiResult(errorCode: Int) {
        ProgressHUD.showError(ErrorCode[errorCode])
    }
}

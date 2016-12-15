//
//  Messages.swift
//  PerseusShelfUnion
//
//  Created by dmql on 16/12/14.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import Foundation

class Messages: NSObject {
    var Code = [Int:String]()
    override init() {
        Code[0x1001] = "请输入用户名和密码"
        Code[0x2001] = "刷新中"
        Code[0x2002] = "刷新成功"
        Code[0x2003] = "刷新失败"
    }
    
    
    func show(errorCode: Int) {
        ProgressHUD.show(Code[errorCode])
    }
    
    func showError(errorCode: Int) {
        ProgressHUD.showError(Code[errorCode])
    }
}

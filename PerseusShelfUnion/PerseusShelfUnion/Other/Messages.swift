//
//  Messages.swift
//  PerseusShelfUnion
//
//  Created by dmql on 16/12/14.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//
/**
 *　　　　　　　　┏┓　　　┏┓+ +
 *　　　　　　　┏┛┻━━━┛┻┓ + +
 *　　　　　　　┃　　　　　　　┃
 *　　　　　　　┃　　　━　　　┃ ++ + + +
 *　　　　　　 ████━████ ┃+
 *　　　　　　　┃　　　　　　　┃ +
 *　　　　　　　┃　　　┻　　　┃
 *　　　　　　　┃　　　　　　　┃ + +
 *　　　　　　　┗━┓　　　┏━┛
 *　　　　　　　　　┃　　　┃
 *　　　　　　　　　┃　　　┃ + + + +
 *　　　　　　　　　┃　　　┃　　　　Code is far away from bug with the animal protecting
 *　　　　　　　　　┃　　　┃ + 　　　　神兽保佑,代码无bug
 *　　　　　　　　　┃　　　┃
 *　　　　　　　　　┃　　　┃　　+
 *　　　　　　　　　┃　 　　┗━━━┓ + +
 *　　　　　　　　　┃ 　　　　　　　┣┓
 *　　　　　　　　　┃ 　　　　　　　┏┛
 *　　　　　　　　　┗┓┓┏━┳┓┏┛ + + + +
 *　　　　　　　　　　┃┫┫　┃┫┫
 *　　　　　　　　　　┗┻┛　┗┻┛+ + + +
 */

import Foundation

class Messages: NSObject {
    var Code = [Int:String]()
    override init() {
        Code[0x1000] = "请输入用户名和密码"
        Code[0x1001] = "用户名或密码错误"
        Code[0x1002] = "无法连接服务器"
        Code[0x1003] = "登录失败"
        Code[0x1004] = "登录中"
        Code[0x1005] = "登录成功"
        Code[0x1006] = "没有该用户"
        Code[0x1007] = "该用户尚未启动"
        Code[0x1008] = "注册中"
        Code[0x1009] = "注册成功"
        Code[0x1010] = "用户名已存在"
        Code[0x1011] = "抢单成功"
        Code[0x1012] = "抢单失败"
        
        Code[0x2002] = "刷新成功"
        Code[0x2003] = "刷新失败"
        
        Code[0x3000] = "请输入用户名"
        Code[0x3001] = "请输入密码"
        Code[0x3002] = "请输入公司名"
        Code[0x3003] = "验证码错误"
        Code[0x3004] = "请确认密码"
    }
    
    
    func show(code: Int) {
        ProgressHUD.showSuccess(Code[code])
    }
    
    func showNow(code: Int){
        ProgressHUD.show(Code[code])
    }
    
    func showError(code: Int) {
        ProgressHUD.showError(Code[code])
    }
}

//
//  UserReposity.swift
//  PerseusShelfUnion
//
//  Created by dmql on 16/12/20.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import Foundation
import Alamofire

var BaseUrl = "172.16.101.110:8000/LoginApp"
var httpMethod = "POST"
var timeoutInterval = 10.0 //超时时间

class UserReposity: NSObject, IUserReposity {
    
    func LoginUser(Requesting: Model_LoginUser.Requesting){
        var request =  requestTo(url: "login") //接口名称
        let Response = Model_LoginUser.Response(Code: nil, IsProved: nil, UserID: nil, UserName: nil)
        let parameters = [
            "UserName":Requesting.UserName,
            "Password":Requesting.Password
        ] //传输JSON
        
        
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        Alamofire.request(request).responseJSON { response in
                if response.result.value != nil {
                    //当收到JSON相应时
                    print(response.request as Any)
                    print(response.result.value as Any) //打印内容
                    
                    let json = JSON(data: response.data!) //JSON解析
                    Response.Code = Model_LoginUser.CodeType(rawValue: json["Code"].int!)
                    Response.IsProved = json["IsProved"].int
                    Response.UserID = json["UserID"].string
                    Response.UserName = json["UserName"].string
                }
                else{
                    //当超时时间已过
                    
            }
            //激活通知
            NotificationCenter.default.post(name: Notification.Name(rawValue: "LoginUser"), object: Response)
        }
    }
    
    func RegistrationUser(Requesting: Model_RegistrationUser.Requesting) {
        var request =  requestTo(url: "Reg") //接口名称
        let Response = Model_RegistrationUser.Response(Code: nil, UserName: nil)
        let parameters = [
            "UserName":Requesting.UserName,
            "Password":Requesting.Password,
            "UnitName":Requesting.UnitName
        ] //传输JSON
        print(request)
        
        
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        Alamofire.request(request).responseJSON { response in
            if response.result.value != nil {
                //当收到JSON相应时
                print(response.request as Any)
                print(response.result.value as Any) //打印内容
                let json = JSON(data: response.data!) //JSON解析
                Response.Code = Model_RegistrationUser.CodeType(rawValue: json["Code"].int!)
                Response.UserName = json["UserName"].string
            }
            //激活通知
            NotificationCenter.default.post(name: Notification.Name(rawValue: "RegistrationUser"), object: Response)
        }
    }
    
    private func requestTo(url: String) -> URLRequest {
        return URLRequest(url: URL(string: NSString(format: "http://%@/%@", BaseUrl , url) as String)!)
    }
}

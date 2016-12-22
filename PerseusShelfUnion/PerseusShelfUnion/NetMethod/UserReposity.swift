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
var timeoutInterval = 10.0

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
        Alamofire.request(request as URLRequestConvertible)
            .responseJSON { response in
                if response.result.value != nil {
                    print(response.result.value as Any) //打印内容
                    
                    let json = JSON(data: response.data!)
                    Response.Code = Model_LoginUser.CodeType(rawValue: json["Code"].int!)
                    Response.IsProved = json["IsProved"].int
                    Response.UserID = json["UserID"].string
                    Response.UserName = json["UserName"].string
                }
                NotificationCenter.default.post(name: Notification.Name(rawValue: "LoginUser"), object: Response)
        }
    }
    
    private func requestTo(url: String) -> URLRequest {
        return URLRequest(url: URL(string: NSString(format: "http://%@/%@", BaseUrl , url) as String)!)
    }
}

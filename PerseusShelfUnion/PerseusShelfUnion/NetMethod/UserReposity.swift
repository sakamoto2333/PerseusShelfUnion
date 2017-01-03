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
var imgurl = "http://172.16.101.110:8000"
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
//                    print(response.request as Any)
//                    print(response.result.value as Any) //打印内容
                    
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
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        Alamofire.request(request).responseJSON { response in
            if response.result.value != nil {
                //当收到JSON相应时
//                print(response.request as Any)
//                print(response.result.value as Any) //打印内容
                let json = JSON(data: response.data!) //JSON解析
                Response.Code = Model_RegistrationUser.CodeType(rawValue: json["Code"].int!)
                Response.UserName = json["UserName"].string
            }
            //激活通知
            NotificationCenter.default.post(name: Notification.Name(rawValue: "RegistrationUser"), object: Response)
        }
    }
    
    
    func MyInformation(Requesting: Model_MyInformation.Requesting) {
        var request = requestTo(url: "UserCenters")
        var Response:Model_MyInformation.Response? = Model_MyInformation.Response(UserPic: nil, PhoneNum: nil, UserName: nil, UserMail: nil, Unit: nil, Job: nil, Code: nil)
        let parameters = [
            "UserName":Requesting.UserName
        ]
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        request.httpBody = try! JSONSerialization .data(withJSONObject: parameters, options: [])
        Alamofire.request(request).responseJSON{response in
            if response.result.value != nil{
//                print(response.request as Any)
//                print(response.result.value as Any)
                let json = JSON(data: response.data!)
                if  let Userpic = json["UserPic"].string{
                    Response?.UserPic = imgurl + Userpic}
                Response?.UserMail = json["UserMail"].string
                Response?.Job = json["Job"].string
                Response?.PhoneNum = json["PhoneNum"].string
                Response?.Unit = json["Unit"].string
                Response?.UserName = json["UserName"].string
                if Response?.Code != "已认证"{
                    Response?.Code = "未认证"
                }
            }
            else{
                Response = nil
            }
            NotificationCenter.default.post(name:Notification.Name(rawValue: "UserCenters1"), object:Response)
            
        }
    }
    
    
    func MyData(Requesting: Model_MyData.Requesting) {
        var request = requestTo(url: "UserCenters")
        let Response = Model_MyData.Response(UserPic: nil, PhoneNum: nil, Unit: nil)
        let parameters = [
            "UserName":Requesting.UserName
        ]
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        request.httpBody = try! JSONSerialization .data(withJSONObject: parameters, options: [])
        Alamofire.request(request).responseJSON{response in
            if response.result.value != nil{
//                print(response.request as Any)
//                print(response.result.value as Any)
                let json = JSON(data: response.data!)
                if  let Userpic = json["UserPic"].string{
                    Response.UserPic = imgurl + Userpic}
                Response.Unit = json["Unit"].string
                Response.PhoneNum = json["PhoneNum"].string
            }
            NotificationCenter.default.post(name:Notification.Name(rawValue: "MyData"), object:Response)
        }

    }
    
    func upload(Requesting: String) {
        var request = requestTo(url: "UserCenters")
        
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        //上传图片
        Alamofire.upload(URL(string:Requesting)!, to: "phpurlhere", method: .post, headers:nil)
            .responseString { response in
//                print("Success: \(response.result.isSuccess)")
//                print("Response String: \(response.result.value)")
                Messages().show(code: 0x2006)
        }
        
//        Alamofire.upload(URL(, to: request, method: .post, headers: nil)
        
    }
    
    private func requestTo(url: String) -> URLRequest {
        return URLRequest(url: URL(string: NSString(format: "http://%@/%@", BaseUrl , url) as String)!)
    }
}

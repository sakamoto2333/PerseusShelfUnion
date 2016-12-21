//
//  UserReposity.swift
//  PerseusShelfUnion
//
//  Created by dmql on 16/12/20.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import Foundation
import Alamofire

var BaseUrl2 = "172.16.101.49:8082/LoginApp"

func LoginUser(UserName:String, UserPassword:String){
    let urlStr = NSString(format: "http://%@/%@", BaseUrl2 , "LoginIn") as String
    
    let parameters = [
        "UserName":UserName,
        "UserPassword":UserPassword
    ]
    Alamofire.request(urlStr, parameters: parameters).responseJSON { response in
        print(response.request!)  // original URL request
        print(response.response!) // URL response
        
        if let JSON = response.result.value {
            print("JSON: \(JSON)") //具体如何解析json内容可看下方“响应处理”部分
        }
        else{
            print("无连接")
        }
    }
    
}

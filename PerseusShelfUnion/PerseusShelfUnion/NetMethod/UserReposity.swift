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


func LoginUser(UserName:String, UserPassword:String){
    var request = URLRequest(url: URL(string: NSString(format: "http://%@/%@", BaseUrl , "login") as String)!)
    request.httpMethod = "POST"
    let parameters = [
        "UserName":UserName,
        "UserPassword":UserPassword
    ]
    request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
    Alamofire.request(request as URLRequestConvertible)
        .responseJSON { response in
            if response.result.value != nil {
                print(response.result.value as Any) //具体如何解析json内容可看下方“响应处理”部分
            }
            else{
                print("错误")
            }
    }
    
}

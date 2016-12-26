//
//  OrdersReposity.swift
//  PerseusShelfUnion
//
//  Created by 123 on 16/12/26.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import Foundation
import Alamofire

var BaseOrderUrl = "172.16.101.110:8000/RequireApp"
//var httpMethod = "POST"
//var timeoutInterval = 10.0 //超时时间

class OrdersReposity: NSObject, IOrdersReposity {
    
    func TakeOrders(){
        var request =  requestTo(url: "RobOrderList") //接口名称
        var Response = [Model_TakeOrders.Response(InstallCycle: nil, InstallPlace: nil, RobOrderID: nil, StartTime: nil, Code: nil, Title: nil, Tonnage: nil)]
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        Alamofire.request(request).responseJSON { response in
            if response.result.value != nil {
                //当收到JSON相应时
                print(response.request as Any)
                
                let json = JSON(data: response.data!) //JSON解析
                for i in 0..<json.count {
                    let date = self.dateTo(datetime: json[i]["StartTime"].string!)
                    Response.append(Model_TakeOrders.Response(
                        InstallCycle: json[i]["InstallCycle"].string,
                        InstallPlace: json[i]["InstallPlace"].string,
                        RobOrderID: json[i]["RobOrderID"].int,
                        StartTime: date,
                        Code: Model_TakeOrders.CodeType(rawValue: json[i]["StateCode"].int!),
                        Title: json[i]["Title"].string,
                        Tonnage: json[i]["Tonnage"].string))
                }
            }
            //激活通知
            NotificationCenter.default.post(name: Notification.Name(rawValue: "TakeOrders"), object: Response)
        }
    }
    
    private func requestTo(url: String) -> URLRequest {
        return URLRequest(url: URL(string: NSString(format: "http://%@/%@", BaseOrderUrl , url) as String)!)
    }
    
    private func dateTo(datetime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let a = datetime.replacingOccurrences(of: "T", with: " ")
        let data = dateFormatter.date(from: a)
        let datestring = DateFormatter.localizedString(from: data!, dateStyle: .short, timeStyle: .none)
        return datestring
    }
}



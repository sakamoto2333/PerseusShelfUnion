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
        var request =  requestTo(crotroller: BaseOrderUrl, url: "RobOrderList") //接口名称
        var Response: [Model_TakeOrders.Response]? = [Model_TakeOrders.Response(InstallCycle: nil, InstallPlace: nil, RobOrderID: nil, StartTime: nil, Code: nil, Title: nil, Tonnage: nil)]
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        Alamofire.request(request).responseJSON { response in
            if response.result.value != nil {
                //当收到JSON相应时
//                print(response.request as Any)
//                print(response.result.value as Any)
                Response?.removeAll()
                
                let json = JSON(data: response.data!) //JSON解析
                for i in 0..<json.count {
                    let date = self.dateTo(datetime: json[i]["StartTime"].string!)
                    Response?.append(Model_TakeOrders.Response(
                        InstallCycle: json[i]["InstallCycle"].string,
                        InstallPlace: json[i]["InstallPlace"].string,
                        RobOrderID: Int(json[i]["RobOrderID"].string!),
                        StartTime: date,
                        Code: Model_TakeOrders.CodeType(rawValue: json[i]["StateCode"].int!),
                        Title: json[i]["Title"].string,
                        Tonnage: json[i]["Tonnage"].string))
                }
            }
            else {
                Response = nil
            }
            //激活通知
            NotificationCenter.default.post(name: Notification.Name(rawValue: "TakeOrders"), object: Response)
        }
    }
    
    func TakeOrderDetails(Requesting: Model_TakeOrderDetails.Requesting) {
        var request = requestTo(crotroller: BaseOrderUrl, url: "RobOrderInfo") //接口名称
        let Response = Model_TakeOrderDetails.Response(InsAtticLayer: nil, InsBeamHgh: nil, InsHeight: nil, InsName: nil, InsFork: nil, InsCycle: nil, InsPlace: nil, InsMoney: nil, Weight: nil, InsPhone: nil, InsRemarks: nil, StartTime: nil, Structure: nil, Tonnage: nil, InsType: nil)
        let parameters = [
            "RobOrderID":Requesting.RobOrderID
        ] //传输JSON
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        Alamofire.request(request).responseJSON { response in
            if response.result.value != nil {
                //当收到JSON相应时
//                print(response.request as Any)
//                print(response.result.value as Any)
                
                let json = JSON(data: response.data!) //JSON解析
                Response.InsAtticLayer = json["Attic"].string! + "层"
                Response.InsBeamHgh = json["Beam"].string
                Response.InsHeight = json["Column"].string
                Response.InsName = json["Contacts"].string
                Response.InsFork = json["Fork"].string
                Response.InsCycle = json["InstallCycle"].string
                Response.InsPlace = json["InstallPlace"].string
                Response.InsMoney = json["OrderOffer"].string! + json["Weight"].string!
                Response.InsPhone = json["Phone"].string
                Response.InsRemarks = json["Remarks"].string
                Response.StartTime = self.date(date: json["StartTime"].string!)
                Response.Structure = json["Structure"].string
                Response.Tonnage = json["Tonnage"].string
                Response.InsType = json["Type"].string
            }
            //激活通知
            NotificationCenter.default.post(name: Notification.Name(rawValue: "OrderDetails"), object: Response)
        }
    }
    
    func MyOrders() {
        var request = requestTo(crotroller: BaseOrderUrl, url: "Order") //接口名称
        var Response: [Model_MyOrders.Response]? = [Model_MyOrders.Response(InsCycle: nil, InsPlace: nil, MyOrderID: nil, Title: nil, StartTime: nil, StateCode: nil, Tonnage: nil)]
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        Alamofire.request(request).responseJSON { response in
            if response.result.value != nil {
                //当收到JSON相应时
//                print(response.request as Any)
//                print(response.result.value as Any)
                Response?.removeAll()
                
                let json = JSON(data: response.data!) //JSON解析
                for i in 0..<json.count {
                    Response?.append(Model_MyOrders.Response(
                        InsCycle: json[i]["InstallCycle"].string,
                        InsPlace: json[i]["InstallPlace"].string,
                        MyOrderID: json[i]["MyOrderID"].string,
                        Title: json[i]["Title"].string,
                        StartTime: self.dateTo2(datetime: json[i]["StartTime"].string!),
                        StateCode: Model_MyOrders.CodeType(rawValue: json[i]["StateCode"].int!),
                        Tonnage: json[i]["Tonnage"].string))
                }
            }
            else {
                Response = nil
            }
            //激活通知
            NotificationCenter.default.post(name: Notification.Name(rawValue: "MyOrders"), object: Response)
        }
        
    }
    
    func GetOrder(Requesting: Model_GetOrder.Requesting) {
        var request =  requestTo(crotroller: BaseOrderUrl, url: "RobOrderSubmit") //接口名称
        var Response: Model_TakeOrderDetails.CodeType!
        let parameters = [
            "RobOrderID":Requesting.RobOrderID,
            "OfferMoney":Requesting.OfferMoney,
            "OfferWeight":Requesting.OfferWeight
        ]
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        Alamofire.request(request).responseJSON { response in
            if response.result.value != nil {
                //当收到JSON相应时
                print(response.request as Any)
                print(response.result.value as Any)
                
                let json = JSON(data: response.data!) //JSON解析
                Response = Model_TakeOrderDetails.CodeType(rawValue: json["Code"].int!)!
            }
            //激活通知
            NotificationCenter.default.post(name: Notification.Name(rawValue: "GetOrder"), object: Response)
            
        }
    }
    
    private func requestTo(crotroller: String, url: String) -> URLRequest {
        return URLRequest(url: URL(string: NSString(format: "http://%@/%@", crotroller , url) as String)!)
    }
    
    private func dateTo(datetime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let a = datetime.replacingOccurrences(of: "T", with: " ")
        let data = dateFormatter.date(from: a)
        let datestring = DateFormatter.localizedString(from: data!, dateStyle: .short, timeStyle: .none)
        return datestring
    }
    
    private func dateTo2(datetime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let a = datetime.replacingOccurrences(of: "T", with: " ")
        let data = dateFormatter.date(from: a)
        let datestring = DateFormatter.localizedString(from: data!, dateStyle: .short, timeStyle: .none)
        return datestring
    }
    
    private func date(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let data = dateFormatter.date(from: date)
        let datestring = DateFormatter.localizedString(from: data!, dateStyle: .short, timeStyle: .none)
        return datestring
    }
}



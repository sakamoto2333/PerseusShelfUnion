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
var PlanOrder = "172.16.101.110:8000/ScheduleApp"

class OrdersReposity: NSObject, IOrdersReposity {
    
    func TakeOrders(){
        var request =  requestTo(crotroller: BaseOrderUrl, url: "RobOrderList") //接口名称
        var Response: [Model_TakeOrders.Response]?
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        Alamofire.request(request).responseJSON { response in
            if response.result.value != nil {
                //当收到JSON相应时
//                print(response.request as Any)
                print(response.result.value as Any)
                Response?.removeAll()
                
                let json = JSON(data: response.data!) //JSON解析
                for i in 0..<json.count {
                    Response?.append(Model_TakeOrders.Response(
                        InstallCycle: json[i]["InstallCycle"].string,
                        InstallPlace: json[i]["InstallPlace"].string,
                        RobOrderID: Int(json[i]["RobOrderID"].string!),
                        StartTime: self.datelast(date: json[i]["StartTime"].string!),
                        Code: Model_TakeOrders.CodeType(rawValue: json[i]["StateCode"].int!),
                        Title: json[i]["Title"].string,
                        Tonnage: json[i]["Tonnage"].string))
                }
            }
            else{
                Response = nil
            }
            //激活通知
            NotificationCenter.default.post(name: Notification.Name(rawValue: "TakeOrders"), object: Response)
        }
    }
    
    func TakeOrderDetails(Requesting: Model_TakeOrderDetails.Requesting) {
        var request = requestTo(crotroller: BaseOrderUrl, url: "RobOrderInfo") //接口名称
        let Response: Model_TakeOrderDetails.Response? = nil
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
                Response?.InsAtticLayer = json["Attic"].string! + "层"
                Response?.InsBeamHgh = json["Beam"].string
                Response?.InsHeight = json["Column"].string
                Response?.InsName = json["Contacts"].string
                Response?.InsFork = json["Fork"].string
                Response?.InsCycle = json["InstallCycle"].string
                Response?.InsPlace = json["InstallPlace"].string
                Response?.InsMoney = json["OrderOffer"].string! + json["Weight"].string!
                Response?.InsPhone = json["Phone"].string
                Response?.InsRemarks = json["Remarks"].string
                Response?.StartTime = self.date(date: json["StartTime"].string!)
                Response?.Structure = json["Structure"].string
                Response?.Tonnage = json["Tonnage"].string
                Response?.InsType = json["Type"].string
            }
            //激活通知
            NotificationCenter.default.post(name: Notification.Name(rawValue: "OrderDetails"), object: Response)
        }
    }
    
    func MyOrders() {
        var request = requestTo(crotroller: BaseOrderUrl, url: "Order") //接口名称
        var Response: [Model_MyOrders.Response]?
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        Alamofire.request(request).responseJSON { response in
            if response.result.value != nil {
                //当收到JSON相应时
//                print(response.request as Any)
                print(response.result.value as Any)
                Response?.removeAll()
                
                let json = JSON(data: response.data!) //JSON解析
                for i in 0..<json.count {
                    if Model_MyOrders.CodeType(rawValue: json[i]["StateCode"].int!) != Model_MyOrders.CodeType.审核通过 &&
                       Model_MyOrders.CodeType(rawValue: json[i]["StateCode"].int!) != Model_MyOrders.CodeType.审核失败 &&
                       Model_MyOrders.CodeType(rawValue: json[i]["StateCode"].int!) != Model_MyOrders.CodeType.未审核{
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
            }
            else{
                Response = nil
            }
            //激活通知
            NotificationCenter.default.post(name: Notification.Name(rawValue: "MyOrders"), object: Response)
        }
        
    }
    
    func MyOrderDetails(Requesting: String) {
        var request = requestTo(crotroller: BaseOrderUrl, url: "OrderInfo") //接口名称
        var Response: Model_TakeOrderDetails.Response? = Model_TakeOrderDetails.Response(InsAtticLayer: nil, InsBeamHgh: nil, InsHeight: nil, InsName: nil, InsFork: nil, InsCycle: nil, InsPlace: nil, InsMoney: nil, Weight: nil, InsPhone: nil, InsRemarks: nil, StartTime: nil, Structure: nil, Tonnage: nil, InsType: nil)
        let parameters = [
            "OrderID": Requesting
        ] //传输JSON
//        print(request)
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        Alamofire.request(request).responseJSON { response in
            if response.result.value != nil {
                //当收到JSON相应时
//                print(response.result.value as Any)
                
                let json = JSON(data: response.data!) //JSON解析
                Response?.InsAtticLayer = json["Attic"].string! + "层"
                Response?.InsBeamHgh = json["Beam"].string
                Response?.InsHeight = json["Column"].string
                Response?.InsName = json["Contacts"].string
                Response?.InsFork = json["Fork"].string
                Response?.InsCycle = json["InstallCycle"].string
                Response?.InsPlace = json["InstallPlace"].string
                Response?.InsMoney = json["OrderOffer"].string! + json["Weight"].string!
                Response?.InsPhone = json["Phone"].string
                Response?.InsRemarks = json["Remarks"].string
                Response?.StartTime = self.date(date: json["StartTime"].string!)
//                print(json["StartTime"].string!)
//                Response?.StartTime = json["StartTime"].string
                Response?.Structure = json["Structure"].string
                Response?.Tonnage = json["Tonnage"].string
                Response?.InsType = json["Type"].string
            }
            else {
                Response = nil
            }
            //激活通知
            NotificationCenter.default.post(name: Notification.Name(rawValue: "MyOrderDetail"), object: Response)
        }
    }
    
    func MyPlan(Requesting: String) {
        var request = requestTo(crotroller: PlanOrder, url: "ScheduleProcess") //接口名称
        var Response: Model_MyPlan.Response? = Model_MyPlan.Response(Number: nil, Code: nil)
        let parameters = [
            "OrderID": Requesting
        ]
        //        print(request)
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        Alamofire.request(request).responseJSON { response in
            if response.result.value != nil {
                //当收到JSON相应时
                print(response.result.value as Any)
                
                let json = JSON(data: response.data!)
                Response?.Number = json["DayNumber"].int
                Response?.Code = json["Code"].int
            }
            else {
                Response = nil
            }
            //激活通知
            NotificationCenter.default.post(name: Notification.Name(rawValue: "MyPlan"), object: Response)
        }
    }
    
    func MyPlanDetail(Requesting: Model_MyPlanDetail.Requesting, IsRefresh: Bool) {
        var request = requestTo(crotroller: PlanOrder, url: "ScheduleList") //接口名称
        var Response: [Model_MyPlanDetail.Response]? = [Model_MyPlanDetail.Response(Code: nil, ProcessID: nil, Procedure: nil, Tools: nil, LiablePerson: nil, Manual: nil, DayItemTime: nil)]
        let parameters = [
            "OrderID": Requesting.OrderID as Any,
            "DayItem": Requesting.Day as Any
        ] as [String : Any]
        //        print(request)
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        Alamofire.request(request).responseJSON { response in
            if response.result.value != nil {
                //当收到JSON相应时
//                print(response.result.value as Any)
                Response?.removeAll()
                let json = JSON(data: response.data!)
                for i in 0..<json.count {
//                    print(json[i]["DayItemTime"].string!)
                    Response?.append(Model_MyPlanDetail.Response(
                        Code: json[i]["StateCode"].int,
                        ProcessID: json[i]["ProcessID"].string,
                        Procedure: json[i]["Procedure"].string,
                        Tools: json[i]["Tools"].string,
                        LiablePerson: json[i]["LiablePerson"].string,
                        Manual: json[i]["Manual"].string,
                        DayItemTime: self.dateTo(datetime: json[i]["DayItemTime"].string!)))
                }
            }
            else {
                Response = nil
            }
            //激活通知
            if IsRefresh == true {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "RefreshMyPlanDetail"), object: Response)
            }
            else {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "MyPlanWhich"), object: Response)
            }
        }
    }
    
    func MyPlanDetailDelete(ProcessID: String, DayItem: Int) {
        var request = requestTo(crotroller: PlanOrder, url: "ScheduleDelete") //接口名称
        var Response: Int?
        let parameters = [
            "ProcessID": ProcessID,
            "DayItem": DayItem,
            ] as [String : Any]
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        Alamofire.request(request).responseJSON { response in
            if response.result.value != nil {
                //当收到JSON相应时
//                print(response.result.value as Any)
                let json = JSON(data: response.data!)
                Response = json["Code"].int
            }
            else {
                Response = nil
            }
            //激活通知
            NotificationCenter.default.post(name: Notification.Name(rawValue: "MyPlanDetailDelete"), object: Response)
        }
    }
    
    func MyPlanDetailEnd(ProcessID: String, DayItem: Int) {
        var request = requestTo(crotroller: PlanOrder, url: "ScheduleFinish") //接口名称
        var Response: Int?
        let parameters = [
            "ProcessID": ProcessID,
            "DayItem": DayItem,
            ] as [String : Any]
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        Alamofire.request(request).responseJSON { response in
            if response.result.value != nil {
                //当收到JSON相应时
                print(response.result.value as Any)
                let json = JSON(data: response.data!)
                Response = json["Code"].int
            }
            else {
                Response = nil
            }
            //激活通知
            NotificationCenter.default.post(name: Notification.Name(rawValue: "MyPlanDetailEnd"), object: Response)
        }
    }
    
    func MyPlanEnd(OfferID: String, UserID: String) {
        var request = requestTo(crotroller: PlanOrder, url: "FinishOrder") //接口名称
        var Response: Int?
        let parameters = [
            "ProcessID": OfferID,
            "DayItem": UserID,
            ]
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        Alamofire.request(request).responseJSON { response in
            if response.result.value != nil {
                //当收到JSON相应时
                print(response.result.value as Any)
                let json = JSON(data: response.data!)
                Response = json["Code"].int
            }
            else {
                Response = nil
            }
            //激活通知
            NotificationCenter.default.post(name: Notification.Name(rawValue: "MyPlanEnd"), object: Response)
        }
    }
    
    func OrderEvaluation(OrderID: String) {
        var request = requestTo(crotroller: PlanOrder, url: "Evaluate") //接口名称
        var Response: Model_Evaluation.Response? = Model_Evaluation.Response(Code: nil, EvalSatisfied: nil, EvalQuality: nil, EvalAccident: nil, EvalReachRate: nil, EvalContent: nil, EvalManagement: nil)
        let parameters = ["InstallID": OrderID]
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        Alamofire.request(request).responseJSON { response in
            if response.result.value != nil {
                //当收到JSON相应时
                print(response.result.value as Any)
                let json = JSON(data: response.data!)
                Response?.Code = json["Code"].int
                Response?.EvalSatisfied = json["Satisfaction"].double
                Response?.EvalQuality = json["Quality"].double
                Response?.EvalAccident =  json["Safety"].double
                Response?.EvalReachRate = json["Deliveryrate"].double
                Response?.EvalContent =  json["EvaluateContent"].string
                Response?.EvalManagement =  json["Manage"].double
            }
            else {
                Response = nil
            }
            //激活通知
            NotificationCenter.default.post(name: Notification.Name(rawValue: "OrderEvaluation"), object: Response)
        }
    }
    
    func MyPlanAdd(Requesting: Model_MyPlanAdd.Requesting) {
        var request = requestTo(crotroller: PlanOrder, url: "ScheduleAdd") //接口名称
        var Response: Model_MyPlanAdd.Code?
        let parameters = [
            "Procedure": Requesting.Procedure as Any,
            "Tools": Requesting.Tools as Any,
            "LiablePerson": Requesting.LiablePerson as Any,
            "Manual": Requesting.Manual as Any,
            "DayItem": Requesting.DayItem as Any,
            "OrderID": Requesting.OrderID as Any
        ] as [String : Any]
        //        print(request)
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        Alamofire.request(request).responseJSON { response in
            if response.result.value != nil {
                //当收到JSON相应时
//                print(response.result.value as Any)
                let json = JSON(data: response.data!)
                Response = Model_MyPlanAdd.Code(rawValue: json["Code"].int!)
            }
            else {
                Response = nil
            }
            //激活通知
            NotificationCenter.default.post(name: Notification.Name(rawValue: "MyPlanAdd"), object: Response)
        }
    }
    
    func GetOrder(Requesting: Model_GetOrder.Requesting) {
        var request =  requestTo(crotroller: BaseOrderUrl, url: "RobOrderSubmit") //接口名称
        var Response: Model_TakeOrderDetails.CodeType? = nil
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
//                print(response.request as Any)
//                print(response.result.value as Any)
                
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
        let index = datetime.index(datetime.startIndex, offsetBy: 10)
        let a = datetime.substring(to: index)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let data = dateFormatter.date(from: a)
        let datestring = DateFormatter.localizedString(from: data!, dateStyle: .long, timeStyle: .none)
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
    
    private func datelast(date: String) -> String {
        let index = date.index(date.startIndex, offsetBy: 10)
        let a = date.substring(to: index)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let data = dateFormatter.date(from: a)
        let datestring = DateFormatter.localizedString(from: data!, dateStyle: .short, timeStyle: .none)
        return datestring
    }
}



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
              print(json)
            }
            else{
                Response = nil
            }
            NotificationCenter.default.post(name:Notification.Name(rawValue: "UserCenters1"), object:Response)
            
        }
    }
    
    func MyInformationEdit(Requesting: Model_MyInformation.Response) {
        var request = requestTo(url: "UserEdit")
        let parameters = [
            "UserName":Requesting.UserName,
            "UserPhone":Requesting.PhoneNum,
            "UserMail":Requesting.UserMail,
            "UserUnit":Requesting.Unit,
            "UserJob":Requesting.Job,
            "UserID":UserId
        ]
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        request.httpBody = try! JSONSerialization .data(withJSONObject: parameters, options: [])
        Alamofire.request(request).responseJSON{response in
            if response.result.value != nil{
                var json = JSON(data: response.data!)
            }
            NotificationCenter.default.post(name:Notification.Name(rawValue: "UserEdit"), object:nil)
            
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
    
    func download(Requesting: Model_ImageData.Requesting){
        let destination: DownloadRequest.DownloadFileDestination = { _, response in
            let imagename = "\(Requesting.DataName).png"
            let fileURL = UploadImage().fileInDocumentsDirectory(filename: imagename)
            //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (URL(fileURLWithPath: fileURL), [.removePreviousFile, .createIntermediateDirectories])
            
        }
        Alamofire.download(Requesting.DataUrl, to: destination)
            .response { response in
                print(response)
                if (response.destinationURL?.path) != nil {
                    print(response.destinationURL?.path as Any)
                    switch Requesting.DataName {
                    case .UserImage:
                        NotificationCenter.default.post(name:Notification.Name(rawValue: "MyDataImage"), object: Model_ImageData.Response(FileUrl: (response.destinationURL?.path)!, DataName: Requesting.DataName))
                        break
                    case .UserImage1:
                        NotificationCenter.default.post(name:Notification.Name(rawValue: "MyDataImage1"), object: Model_ImageData.Response(FileUrl: (response.destinationURL?.path)!, DataName: Requesting.DataName))
                        break
                    default:
                        NotificationCenter.default.post(name:Notification.Name(rawValue: "MyCertificateImage"), object: Model_ImageData.Response(FileUrl: (response.destinationURL?.path)!, DataName: Requesting.DataName))
                        break
                    }
                }
        }
    }
    
    func upload(Requesting: Model_Upload.Requesting) {
        let imageData = UIImageJPEGRepresentation(Requesting.imageData, 0.1)
        let UserData = Requesting.UserID.data(using: String.Encoding.utf8)
        let strData = String(describing: Requesting.strData.rawValue).data(using: String.Encoding.utf8)
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(strData!, withName: "strData")
                multipartFormData.append(UserData!, withName: "UserData")
                multipartFormData.append(imageData!, withName: "imageData",
                                         fileName:"userimage.png", mimeType: "image/png")
        },
            to: NSString(format: "%@/%@/%@", imgurl , "Ashx" , "UploadPicture.ashx") as String,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.response{ response in
                        let json = JSON(data: response.data!)
                        if Requesting.strData != Model_Upload.PicType.UserImage {
                            NotificationCenter.default.post(name:Notification.Name(rawValue: "uploadcertificate"), object: json.int)
                        }
                        else{
                            NotificationCenter.default.post(name:Notification.Name(rawValue: "MyDataImageUpload"), object: json.int)
                        }
                        
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        })
    }
    
    func GetCertificates(Requesting: String) {
        var request = URLRequest(url: URL(string: NSString(format: "%@/%@", imgurl , "RequireApp/Commpany") as String)!)
        let Response = Model_Certificate.Response(ClimbCard: nil, Qualification: nil, WelderCard: nil, ForkliftCard: nil, ElectricianCard: nil, SafeCard: nil, InsuranceCard: nil, License: nil, msg: nil)
//        print(request)
        let parameters = [
            "UserID": Requesting
        ]
        request.httpMethod = httpMethod
        request.timeoutInterval = timeoutInterval
        request.httpBody = try! JSONSerialization .data(withJSONObject: parameters, options: [])
        Alamofire.request(request).responseJSON{response in
            if response.result.value != nil{
//                print(response.result.value as Any)
                let json = JSON(data: response.data!)
                Response.License = imgurl + json["Business"].string!
                Response.Qualification = imgurl + json["Install"].string!
                Response.ClimbCard = imgurl + json["Climbing"].string!
                Response.ElectricianCard = imgurl + json["Electrician"].string!
                Response.ForkliftCard = imgurl + json["Forklift"].string!
                Response.InsuranceCard = imgurl + json["Insurance"].string!
                Response.SafeCard = imgurl + json["SafetyPerson"].string!
                Response.WelderCard = imgurl + json["Welder"].string!
                Response.msg = String(json["StateCode"].int!)
            }
            NotificationCenter.default.post(name:Notification.Name(rawValue: "getCertificates"), object: Response)
        }
    }
    
    private func requestTo(url: String) -> URLRequest {
        return URLRequest(url: URL(string: NSString(format: "http://%@/%@", BaseUrl , url) as String)!)
    }
}

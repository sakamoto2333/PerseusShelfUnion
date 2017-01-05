//
//  Upload.swift
//  PerseusShelfUnion
//
//  Created by dmql on 17/1/5.
//  Copyright © 2017年 XHVolunteeriOS. All rights reserved.
//

import Foundation
class Model_Upload: NSObject {
    ///请求
    class Requesting:NSObject{
        var strData: PicType
        var UserID: String
        var imageData: UIImage
        
        init(strData: PicType, UserID: String, imageData: UIImage) {
            self.strData = strData
            self.UserID = UserID
            self.imageData = imageData
        }
    }
    enum PicType:String {
        case UserImage = "0"
        case CompanyQualification = "1"
        case CompanyClimbCard = "2"
        case CompanyWelderCard = "3"
        case CompanyForkliftCard = "4"
        case CompanyElectricianCard = "5"
        case CompanySafeCard = "6"
        case CompanyInsuranceCard = "7"
        case CompanyLicense = "8"
    }
    
}

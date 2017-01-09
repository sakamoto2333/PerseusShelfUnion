//
//  ImageData.swift
//  PerseusShelfUnion
//
//  Created by dmql on 17/1/9.
//  Copyright © 2017年 XHVolunteeriOS. All rights reserved.
//

import Foundation
class Model_ImageData: NSObject {
    ///请求
    class Requesting:NSObject{
        var DataUrl: String
        var DataName: DataType
        init(DataUrl: String, DataName: DataType) {
            self.DataUrl = DataUrl
            self.DataName = DataName
        }
    }
    ///响应
    class Response:NSObject{
        var FileUrl: String
        var DataName: DataType
        init(FileUrl: String, DataName: DataType) {
            self.FileUrl = FileUrl
            self.DataName = DataName
        }
    }
    enum DataType:String {
        case UserImage = "UserImage"
        case UserImage1 = "UserImage1"
        case CompanyQualification = "CompanyQualification"
        case CompanyClimbCard = "CompanyClimbCard"
        case CompanyWelderCard = "CompanyWelderCard"
        case CompanyForkliftCard = "CompanyForkliftCard"
        case CompanyElectricianCard = "CompanyElectricianCard"
        case CompanySafeCard = "CompanySafeCard"
        case CompanyInsuranceCard = "CompanyInsuranceCard"
        case CompanyLicense = "CompanyLicense"
    }
}

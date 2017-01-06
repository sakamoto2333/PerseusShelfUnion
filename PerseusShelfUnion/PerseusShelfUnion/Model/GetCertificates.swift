//
//  GetCertificates.swift
//  PerseusShelfUnion
//
//  Created by 123 on 17/1/6.
//  Copyright © 2017年 XHVolunteeriOS. All rights reserved.
//

import Foundation
class Model_Certificate: NSObject {
    ///响应
    class Response:NSObject{
        var ClimbCard: String?
        var Qualification: String?
        var WelderCard: String?
        var ForkliftCard: String?
        var ElectricianCard: String?
        var SafeCard: String?
        var InsuranceCard: String?
        var License: String?
        var msg: String?
        init(ClimbCard: String?,
             Qualification: String?,
             WelderCard: String?,
             ForkliftCard: String?,
             ElectricianCard: String?,
             SafeCard: String?,
             InsuranceCard: String?,
             License: String?,
             msg: String?) {
            self.ClimbCard = ClimbCard
            self.Qualification = Qualification
            self.WelderCard = WelderCard
            self.ForkliftCard = ForkliftCard
            self.ElectricianCard = ElectricianCard
            self.SafeCard = SafeCard
            self.InsuranceCard = InsuranceCard
            self.License = License
            self.msg = msg
        }
    }
}
